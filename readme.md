# Cytora Assessment

### Overview

Deploys a basic lambda function with the capability to update infrastructure and code separately.

### CI/CD

Deployment pipeline runs on merge to main. Feature branches verify that infrastructure changes are valid.

### CircleCi

A custom docker image was created to simplify creating the pipeline in CircleCI.