variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "web_sg_id" {
  type = string
}

variable "app_sg_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}