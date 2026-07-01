environment     = "staging"
location        = "UK South"
project_acronym = "cmrc"
vnet_rg         = "RG-Connectivity"
vnet_name       = "VNET-UKS-CaseManagment-PreProd"
aad_sp_name     = "Azure Pipeline: CMRC-PreProd"

asp_auto_scale_enabled     = true
asp_zone_balancing_enabled = false

asp_linux_sku          = "P0v3" # Basic plan does not allow for deployment slots
asp_linux_worker_count = 1

asp_windows_sku          = "P0v4" # Basic plan does not allow for deployment slots
asp_windows_worker_count = 1
