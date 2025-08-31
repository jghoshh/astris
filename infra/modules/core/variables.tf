variable "project" {
  type        = string
  description = "Project identifier, e.g., 'astris'"
}

variable "env" {
  type        = string
  description = "Environment, e.g., 'dev'"
}

variable "name_prefix" {
  type        = string
  description = "Base name prefix for resources, e.g., 'astris-dev'"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "s3_bucket_name" {
  type    = string
  default = ""
}

variable "s3_versioning" {
  type    = bool
  default = true
}

variable "s3_force_destroy" {
  type    = bool
  default = false
}

variable "ddb_table_name" {
  type    = string
  default = ""
}

variable "publish_to_ssm" {
  type    = bool
  default = true
}

variable "ssm_path_prefix" {
  type    = string
  default = ""
}
