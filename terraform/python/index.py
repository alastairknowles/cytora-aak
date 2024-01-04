import json


def lambda_handler(event, context):
    return {
        'statusCode': 501,
        'body': json.dumps('Not Implemented')
    }
