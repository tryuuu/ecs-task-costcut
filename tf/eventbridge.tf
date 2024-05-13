provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_cloudwatch_event_rule" "stop_ecs_task" {
  name                = "stop-ecs-task-rule"
  schedule_expression = "cron(30 10 * * ? *)" # utc時間であることに注意
}

resource "aws_cloudwatch_event_rule" "start_ecs_task" {
  name                = "start-ecs-task-rule"
  schedule_expression = "cron(30 0 * * ? *)"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "stop-ecs-dev"  # Lambda関数名
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_ecs_task.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "start-ecs-dev"  # Lambda関数名
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_ecs_task.arn
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule      = aws_cloudwatch_event_rule.stop_ecs_task.name
  target_id = "stopEcsTask"
  arn       = "arn:aws:lambda:ap-northeast-1:<アカウントID>:function:stop-ecs-dev"  
}

resource "aws_cloudwatch_event_target" "start_target" {
  rule      = aws_cloudwatch_event_rule.start_ecs_task.name
  target_id = "startEcsTask"
  arn       = "arn:aws:lambda:ap-northeast-1:<アカウントID>:function:start-ecs-dev"  
}
