variable "db_password" {
  type        = string
  description = "Password for the RDS instance"
  sensitive   = true
}