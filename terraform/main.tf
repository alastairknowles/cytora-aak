data "aws_route53_zone" "route53_zone" {
  name = var.domain_name
}

locals {
  gateway_domain_name = "assessment.${var.domain_name}"
}

module "ssl_certificate" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.0"

  domain_name       = local.gateway_domain_name
  zone_id           = data.aws_route53_zone.route53_zone.zone_id
  validation_method = "DNS"

  providers = {
    aws.acm = aws
    aws.dns = aws
  }
}

module "gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "2.2.2"

  name                        = "assessment-http"
  description                 = "Hello World API"
  protocol_type               = "HTTP"
  domain_name                 = local.gateway_domain_name
  domain_name_certificate_arn = module.ssl_certificate.acm_certificate_arn

  integrations = {
    "GET /" = {
      lambda_arn             = module.function.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 1000
    }
  }
}

resource "aws_route53_record" "gateway" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "assessment"
  type    = "A"

  alias {
    name                   = module.gateway.apigatewayv2_domain_name_configuration[0].target_domain_name
    zone_id                = module.gateway.apigatewayv2_domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

data "archive_file" "initial_function_source" {
  type        = "zip"
  source_file = "./python/index.py"
  output_path = "./function.zip"
}

module "function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "6.5.0"

  function_name = "assessment-function"
  description   = "Hello World Function"
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  publish                 = true
  ignore_source_code_hash = true
  create_package          = false
  local_existing_package  = data.archive_file.initial_function_source.output_path

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }
}