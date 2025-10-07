import json
import os
import boto3
from botocore.exceptions import ClientError

# 環境変数から DynamoDB テーブル名を取得
TABLE_NAME = os.environ.get("TABLE_NAME")

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(TABLE_NAME)

def lambda_handler(event, context):
    """
    Lambda entry point
    event には API Gateway またはテストイベントからの入力が入る想定
    """

    try:
        # event の body が JSON 文字列ならパースする
        if isinstance(event.get("body"), str):
            body = json.loads(event["body"])
        else:
            body = event.get("body", {})

        tenant_id = body.get("tenant_id")
        name = body.get("name")

        if not tenant_id or not name:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "tenant_id and name are required"})
            }

        # DynamoDB に書き込み
        table.put_item(
            Item={
                "tenant_id": tenant_id,
                "name": name
            }
        )

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": f"Tenant {tenant_id} created successfully"
            })
        }

    except ClientError as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": f"Unexpected error: {str(e)}"})
        }