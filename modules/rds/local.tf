locals {
  identifier = lower(replace("${var.environment}-${var.application}", " ", "-"))

  # PostgreSQL database names cannot contain hyphens.
  db_name = replace("${local.identifier}_db", "-", "_")
}
