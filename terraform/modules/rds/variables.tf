variable "vpc_id" {
 type        = string
 description = "ID of the VPC"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}