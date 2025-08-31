resource "aws_s3_bucket" "artifacts" {
  bucket        = local.bucket_name
  force_destroy = var.s3_force_destroy
  tags          = local.tags
}

resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  versioning_configuration { status = var.s3_versioning ? "Enabled" : "Suspended" }
}

resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket                  = aws_s3_bucket.artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "index" {
  name         = local.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  attribute {
    name = "trainer_id"
    type = "S"
  }

  global_secondary_index {
    name            = "gsi_trainer_id"
    hash_key        = "trainer_id"
    projection_type = "ALL"
  }

  tags = local.tags
}

resource "aws_sns_topic" "alerts" {
  name = local.topic_name
  tags = local.tags
}


resource "aws_sqs_queue" "commands" {
  name                    = local.queue_name
  sqs_managed_sse_enabled = false
  tags                    = local.tags
}

resource "aws_ssm_parameter" "bucket_name" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/artifacts_bucket"
  type  = "String"
  value = aws_s3_bucket.artifacts.bucket
}

resource "aws_ssm_parameter" "ddb_table_name" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/ddb_table"
  type  = "String"
  value = aws_dynamodb_table.index.name
}

resource "aws_ssm_parameter" "sns_topic_arn" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/sns_topic_arn"
  type  = "String"
  value = aws_sns_topic.alerts.arn
}

resource "aws_ssm_parameter" "sqs_queue_url" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/sqs_queue_url"
  type  = "String"
  value = aws_sqs_queue.commands.url
}