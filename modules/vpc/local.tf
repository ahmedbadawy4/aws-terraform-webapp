locals {
  resource_name = lower(replace("${var.environment}-${var.application}", " ", "-"))
}
