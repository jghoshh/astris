output "bucket_name" { value = module.core.bucket_name }
output "ddb_table_name" { value = module.core.ddb_table_name }
output "sns_topic_arn" { value = module.core.sns_topic_arn }
output "sqs_queue_url" { value = module.core.sqs_queue_url }