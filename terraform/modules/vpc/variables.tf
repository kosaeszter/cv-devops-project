variable "region" {
 type        = string
 description = "AWS region for the VPC"
 default     = "us-east-1"
}
 
variable "vpc_cidr" {
 type        = string
 description = "vpc CIDR value"
 default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
 type        = string
 description = "public_subnet_a CIDR value"
 default     = "10.0.101.0/24"
}

variable "public_subnet_b_cidr" {
 type        = string
 description = "public_subnet_b CIDR value"
 default     = "10.0.102.0/24"
}

variable "private_subnet_a_cidr" {
 type        = string
 description = "private_subnet_a CIDR value"
 default     = "10.0.1.0/24"
}

variable "private_subnet_b_cidr" {
 type        = string
 description = "private_subnet_b CIDR value"
 default     = "10.0.2.0/24"
}
