FROM cimg/base:current-22.04

RUN sudo apt update \
    && sudo apt install python3 \
    && sudo apt install python3-pip \
    && python -m pip install awscliv2 \
    && wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_386.zip \
    && unzip terraform_1.6.6_linux_386.zip \
    && sudo mv terraform /usr/local/bin/ \
    && chmod +x /usr/local/bin/terraform \
    && rm terraform_1.6.6_linux_386.zip \
    && wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.54.12/terragrunt_linux_386 \
    && sudo mv terragrunt_linux_386 /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt