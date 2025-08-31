output "bucket_name" { value = aws_s3_bucket.artifacts.bucket }
output "ddb_table_name" { value = aws_dynamodb_table.index.name }
output "sns_topic_arn" { value = aws_sns_topic.alerts.arn }
output "sqs_queue_url" { value = aws_sqs_queue.commands.url }