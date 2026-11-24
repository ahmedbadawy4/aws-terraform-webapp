variable "environment" {
  description = "Environment name, for example dev or prod."
  type        = string
}

variable "application" {
  description = "Application name."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet the instance runs in."
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group attached to the instance."
  type        = string
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair used for SSH."
  type        = string
}

variable "iam_instance_profile" {
  description = "Name of the instance profile attached to the instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type. It must be an x86_64 type."
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Size of the encrypted root volume in GiB."
  type        = number
  default     = 20
}
