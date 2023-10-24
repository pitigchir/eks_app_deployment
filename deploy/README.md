# Application Deployment on EKS

## Principle of operation

* Infrastructure code set up in this directory containerize and deploy an application. High level operations are as follows;
    * Create a ECR repository to host built docker images
    * Build a container using the configured application source directory
    * Push the container to ECR repository
    * Create EKS service, load balancer and pods required to run containerized application with configured replicaset.
    * Deploy pods with container using configured image version downloaded from ECR repository
    * Update load balancer (Classic) with configuration to connect application listening port
* deploy directory contains following files:
    * main.tf : main terraform file contains the code to deploy application
    * ecr.tf : creates ecr repository
    * build.tf : build the docker container using application source and push to ECR repository
    * variables.tf : contains the definitions of variables
    * terraform.tfvars : contains the configuration values of variables
    * outputs.tf : contains the definition of outputs 

### How to Run

* Make sure aws profile is configured using config/credentials files or exporting access_key and secrets:
    * Start the local docker engine service which requires to build the docker image of the application
    * Start a new terminal and go to deploy directory
    * Update local kubeconfig with eks cluster details using below step mentioned under README of eks-cluster if not done yet. <region> = aws region where eks cluster created, value for <cluster_name> can be obtained by 
      with terraform output
        aws eks update-kubeconfig --region <region> --name <cluster_name>
    * Update terraform.tfvars with suitable variable values. Example values can be found below.

    region                   = "us-east-1"

    environment              = "appdev"

    account                  = <account-name>

    ecr_repo                 = "app-dev-repo"

    image_tag                = "latest"

    src_path                 = "../web-api"

    force_image_rebuild      = false

    kubernetes_config_path   = "~/.kube/config"

    kubernetes_config_context = "<context-name>"

    application_name         = "quotes"

    application_port         = 80

    no_of_replicas           = 2

    * Run the command 'terraform init'
    * Run the command 'terraform plan'
    * Once both init and plan are successful run the command 'terraform apply'
    * Check the outputs using the command 'terraform output'. Take note of Load Balancer hostname with ouput name 'load_balancer_hostname'
    * Verify the container deployment using kubectl commands
    * Verify the application access using http://<load_balancer_hostname>/quotes

### How to deploy new versions of the application

* Once you have done new updates to application it can be deployed with below steps:
    * Update the application source
    * Update image_tag in terraform.tfvars with the new version tag
    * Run the command 'terraform plan'
    * Run the command 'terraform apply'
    * Image with the new version of the application will be deployed   