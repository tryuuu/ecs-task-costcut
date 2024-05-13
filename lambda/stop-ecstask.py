import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')
    response = client.update_service(
        cluster='nippou-cluster',
        service='nippou-service',
        desiredCount=0  # タスク数を0に設定して停止
    )
    return response
