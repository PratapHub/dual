variable "name" {
  type        = string
  description = "Name of the RDS instance"
}


variable "username" {
  type        = string
  description = "Username for the RDS instance"
}

variable "password" {
  type        = string
  description = "Password for the RDS instance"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone in which to create the primary RDS instance"
}

variable "secondary_availability_zone" {
  type        = list(string)
  description = "List of availability zones in which to create secondary RDS instances"
}

variable "primary_availability_zone" {
  type        = string
  description = "List of availability zones in which to create secondary RDS instances"
}

variable "allocated_storage" {
  type        = number
  description = "The amount of storage to allocate for the RDS instance (in GB)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to launch RDS instances in"
}

variable "region" {
  type        = string
  description = "Username for the RDS instance"
}
