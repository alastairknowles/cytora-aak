from unittest import TestCase
from index import lambda_handler


class Test(TestCase):
    def test_lambda_handler(self):
        result = lambda_handler({}, {})
        self.assertEqual(result, {
            'body': 'Hello World',
            'statusCode': 200
        })
