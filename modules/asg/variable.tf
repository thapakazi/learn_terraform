variable "server_port" {
  type        = number
  description = "Application port"
  default     = 8080
}

variable "cluster_name" {
  type = string
  description = "The name to use for all cluster resource"
}

variable "instance_type" {
  type = string
  description = "Type of instance to use"
}

variable "min_size" {
  type        = number
  description = "The min number of EC2 instances in ASG"
}

variable "max_size" {
  type        = number
  description = "The max number of EC2 instances in ASG"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
}
