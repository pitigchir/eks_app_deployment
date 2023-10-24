# EKS cluster creation and application deployment

## Principle of operation & Deployment

* Please refer README files in eks-cluster and deploy directories respectively

## Enhancements

* Use a build pipeline for application build and deployment process
* Use Ingress Controller with Application Load Balancer for secure and controlled access of application urls
* Integrate ACM certificate to ALB for https access
* Integrate WAF with Application Load Balancer for web filtering and security
* Add Cluster Autoscalar to automatically scale nodes in case of node failure or other scalability requirements