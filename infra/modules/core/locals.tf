locals {
  base_tags       = { Project = var.project, Env = var.env }
  tags            = merge(local.base_tags, var.tags)
  computed_bucket = lower(replace("${var.name_prefix}-artifacts", "/[^a-z0-9-]/", "-"))
  bucket_name     = var.s3_bucket_name != "" ? var.s3_bucket_name : substr(local.computed_bucket, 0, 63)
  table_name      = var.ddb_table_name != "" ? var.ddb_table_name : "${var.name_prefix}-index"
  topic_name      = "${var.name_prefix}-alerts"
  queue_name      = "${var.name_prefix}-commands"
  ssm_prefix      = var.ssm_path_prefix != "" ? var.ssm_path_prefix : "/${var.project}/${var.env}"
}
