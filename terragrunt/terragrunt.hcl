remote_state {
  backend = "s3"
generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "cytora-aak-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "cytora-aak-terraform-state"
  }
}

inputs = {
  domain_name = "realalknowles.com"
}