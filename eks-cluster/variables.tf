variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
 type        = string
 description = "Name of the environment"
 default     = "appdev"
}