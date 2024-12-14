locals {
  identifier = lower(replace("${var.environment}-${var.application}", " ", "-"))
}
