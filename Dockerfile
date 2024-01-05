FROM cimg/base:current-22.04

RUN sudo apt update \
    && sudo apt install python3 \
    && sudo apt install python3-pip \
    && python -m pip install awscliv2 \
    && wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_darwin_amd64.zip \
    && unzip terraform_1.6.6_darwin_amd64.zip \
    && sudo mv terraform /usr/local/bin/ \
    && chmod +x /usr/local/bin/terraform \
    && rm terraform_1.6.6_darwin_amd64.zip \
    && wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.54.12/terragrunt_darwin_amd64 \
    && sudo mv terragrunt_darwin_amd64 /usr/local/bin/ \
    && chmod +x /usr/local/bin/terragrunt_darwin_amd64