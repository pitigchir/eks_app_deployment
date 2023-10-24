# EKS CLuster Creation

## Principle of operation

* Infrastructure code set up in this directory creates a EKS cluster using terraform eks modules ( https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest).
  Following resource are created:
    * vpc with multiple public and private subnets on 
    * Internet gateway and public route table
    * NAT Gateway and private route table
    * EKS Cluster with managed node groups
    * Relevant security group for secure communication
* eks-cluster directory contains following files:
    * main.tf : main terraform file contains the code to create eks infrastructure with managed node groups
    * vpc.tf : contains code to create vpc infrastructure with subnets
    * versions.tf : contains the required versions of the used providers
    * variables.tf : contains the definitions of variables
    * terraform.tfvars : contains the configuration values of variables
    * outputs.tf : contains the definition of outputs 

### How to Run

* Make sure aws profile is configured using config/credentials files or exporting access_key and secrets:
    * Start a new terminal and go to eks-cluster directory
    * Update terraform.tfvars with suitable variable values
    * Run the command 'terraform init'
    * Run the command 'terraform plan'
    * Once both init and plan are successful run the command 'terraform apply'. Infrastructure creation process takes around 20 minutes
    * Check the outputs using the command 'terraform output'
    * Update local kubeconfig with eks cluster details using below command. <region> = aws region where eks cluster created, value for <cluster_name> can be obtained by 
      with terraform output
        aws eks update-kubeconfig --region <region> --name <cluster_name>
    * Verify the cluster using kubectl commands. e.g: kubectl get svc