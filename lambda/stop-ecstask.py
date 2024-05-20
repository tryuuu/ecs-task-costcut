import boto3
import json
from datetime import datetime

def datetime_converter(o):
    if isinstance(o, datetime):
        return o.isoformat()

def lambda_handler(event, context):
    client = boto3.client('ecs')
    response = client.update_service(
        cluster='example-cluster',
        service='example-service',
        desiredCount=0  # タスク数を0に設定して停止
    )
    return json.loads(json.dumps(response, default=datetime_converter))
