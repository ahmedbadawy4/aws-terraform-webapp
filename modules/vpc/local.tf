locals {
  resource_name = lower(replace("${var.environment}-${var.application}", " ", "-"))

  # One rule per allowed CIDR block and port, for example "203.0.113.10/32-22".
  ec2_ingress = {
    for pair in setproduct(var.allowed_cidr_blocks, [22, 80]) :
    "${pair[0]}-${pair[1]}" => {
      cidr = pair[0]
      port = pair[1]
    }
  }
}
