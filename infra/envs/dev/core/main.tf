module "core" {
  source          = "../../../modules/core"
  project         = "astris"
  env             = var.env
  name_prefix     = var.name_prefix
  tags            = { Owner = var.owner }
  publish_to_ssm  = true
  ssm_path_prefix = "/astris/${var.env}"
}