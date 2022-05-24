variable "vpc_name" {
  type = string 
}

variable "pub_subnets" {
  type = list(string)
}

variable "priv_subnets" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "cidr" {
  type        = string
}

variable "environment" {
  type    = string
}

variable "ecs_name" {
  type = string
}

variable "ecr_name" {
  type = string
}