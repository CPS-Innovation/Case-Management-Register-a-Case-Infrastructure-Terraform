# environment     = "prod"
# location        = "UK South"
# project_acronym = "cmrc"
# vnet_rg         = "rg-cmrc-connectivity-prod"
# vnet_name       = "vnet-cmrc-prod"
# aad_sp_name     = "Azure Pipeline: CMRC-Prod"

asp_auto_scale_enabled     = true
asp_zone_balancing_enabled = true

asp_linux_sku          = "P0v3"
asp_linux_worker_count = 3

asp_windows_sku          = "P0v4"
asp_windows_worker_count = 3

log_retention_in_days = 90

kv_soft_delete_retention_days = 90
