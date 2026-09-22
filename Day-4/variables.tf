variable "vpc_cidr" {
  description = "cidr block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable  "subnet_cidr" {
    description = "cidr block for the subnet"
    type        = string
    default     = "10.0.0.0/26"
}
