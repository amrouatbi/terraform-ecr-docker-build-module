# Checks if build folder has changed
data "external" "build_folder" {
  program = ["${path.module}/bin/folder_contents.sh", var.dockerfile_folder]
}

# Builds test-service and pushes it into aws_ecr_repository
resource "null_resource" "build_and_push" {
  triggers = {
    build_folder_content_md5 = data.external.build_folder.result.md5
  }
  
  # See build.sh for more details
  provisioner "local-exec" {
    command = "${path.module}/bin/build.sh ${var.dockerfile_folder} ${var.ecr_repository_url}:${var.docker_image_tag} ${var.additional_args}"
    environment = {
      AWS_ACCESS_KEY_ID     = var.aws_access_key_id
      AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
      AWS_DEFAULT_REGION    = var.aws_region
    }
  }
}

