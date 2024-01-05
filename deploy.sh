#!/bin/bash

zip -r -j ./function.zip ./python/*
aws lambda update-function-code --function-name assessment-function  --zip-file fileb://./function.zip

deployed=$(curl -s -o /dev/null -w "%{http_code}" https://assessment.realalknowles.com)
if [ "$deployed" = "200" ]
then
  echo "Deployment succeeded"
  exit 0
fi

echo "Deployment failed"
exit 1