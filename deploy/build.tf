# Build application containers and pushed to ecr repository

locals {
  aws_account = var.account
  aws_region  = var.region
  ecr_registry = "${local.aws_account}.dkr.ecr.${local.aws_region}.amazonaws.com"
  ecr_repo  = var.ecr_repo
  image_tag = var.image_tag
  src_path  = var.src_path
  # sha value generated for the files inside source directory of the application
  dockr_image_src_sha256 = sha256(join("", [for f in fileset(".", "${local.src_path}/**") : file(f)]))
  # Build docker image and push to ecr. Local docker engine should be running
  dockr_build_command = <<-EOT
    aws ecr get-login-password --region ${local.aws_region} | docker login --username AWS --password-stdin ${local.ecr_registry} && docker build -t ${local.ecr_registry}/${local.ecr_repo}:${local.image_tag} -f ${local.src_path}/Dockerfile ${local.src_path}/ && docker push ${local.ecr_registry}/${local.ecr_repo}:${local.image_tag}
    EOT
}

# local-exec for build and push of docker image in case of update of source file or force image rebuild variable set to true

resource "null_resource" "build_push_docker_image" {
  triggers = {
    detect_docker_source_changes = var.force_image_rebuild == true ? timestamp() : local.dockr_image_src_sha256
  }
  provisioner "local-exec" {
    command = local.dockr_build_command
  }
}