import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')
    response = client.update_service(
        cluster='nippou-cluster',
        service='nippou-service',
        desiredCount=1  # タスク数を1にする
    )
    return response
