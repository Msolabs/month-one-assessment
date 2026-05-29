variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "techcorp"
}

variable "bastion_instance_type" {
  description = "EC2 instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "web_instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_type" {
  description = "EC2 instance type for database server"
  type        = string
  default     = "t3.small"
}

variable "key_pair_name" {
  description = "AWS EC2 key pair name"
  type        = string
}

variable "my_ip" {
  description = "Your public IP address for SSH access"
  type        = string
}