#!/bin/bash

jar -cfM ./function.zip -C ./python/ .
aws lambda update-function-code --function-name assessment-function  --zip-file fileb://./function.zip
rm function.zip