module "autoscaling_api" {
  source = "../../../modules/autoscaling"

  location = var.location
  tags     = local.tags
  rg_name  = module.rg.rg_name

  asp_name = module.asp_windows.name
  asp_id   = module.asp_windows.id

  target_service_ids = [module.fa_main.fa_id]

  default_capacity = {
    default = var.asp_windows_worker_count
    minimum = var.asp_windows_worker_count
    maximum = var.asp_windows_worker_count * 3
  }

  scale_metrics = {
    memory = {} # using module defaults
    cpu    = {} # using module defaults
    # currently the volume of requests is too low to set an informed threshold
  }
}
