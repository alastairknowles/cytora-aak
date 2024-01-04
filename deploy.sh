#!/bin/bash

zip -r -j ./function.zip ./python/*
aws lambda update-function-code --function-name assessment-function  --zip-file fileb://./function.zip