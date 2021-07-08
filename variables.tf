variable "dockerfile_folder" {
  type        = string
  description = "This is the folder which contains the Dockerfile"
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}

variable "build_arg" {
  type        = list(string)
  description = "An optional, by default empty list of args to pass to docker build if need be"
  default     = []

variable "aws_access_key_id" {
  type        = string
  description = "Access key used to authenticate"
}

variable "aws_secret_access_key" {
  type        = string
  description = "Secret key used to authenticate"
}

variable "aws_region" {
  type        = string
  description = "AWS region for ECR"
  default     = ""
}

variable "ecr_repository_url" {
  type        = string
  description = "Full url for the ecr repository"
}

