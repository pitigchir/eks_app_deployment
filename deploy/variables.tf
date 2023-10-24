# Variable definitions of deploy

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Name of the environment"
  default     = "appdev"
}

variable "account" {
  type        = number
  description = "aws account number"
}

variable "ecr_repo" {
  type        = string
  description = "Name of the ecr repository"
  default     = "appdev-repo"
}

variable "image_tag" {
  type        = string
  description = "tag of the image"
  default     = "latest"
}

variable "src_path" {
  type        = string
  description = "Source path of the application"
  default     = "../web-api/"
}

variable "force_image_rebuild" {
  type        = bool
  description = "Whether to force the rebuilding of the image"
  default     = false
}

variable "kubernetes_config_path" {
  type        = string
  description = "Configuration file path of kubernetes"
  default     = "~/.kube/config"
}

variable "kubernetes_config_context" {
  type        = string
  description = "configuration context name of kubernetes cluster"
}

variable "application_name" {
  type        = string
  description = "Name of the application deployed on kubernetes"
  default     = "appdev"
}

variable "application_port" {
  type        = number
  description = "Listening port of the application"
  default     = 80
}

variable "no_of_replicas" {
  type        = string
  description = "Number of replicas of the application deployed in kubernetes"
  default     = 2
}
