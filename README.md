# AWS-EKS-Infrastructure-Provisioning-using-Terraform



AWS EKS Infrastructure Provisioning using Terraform

A modular Terraform project that provisions a complete Amazon EKS environment on AWS: networking, IAM, an EKS cluster, and a managed node group, all as reusable code.



Overview

Before this project, the environment was built manually through the console. This project replaces that with Infrastructure as Code, so the same environment can be created, reviewed, and destroyed repeatably across 3 environments (<env names, e.g. dev / test / prod>).

The infrastructure is split into 4 reusable modules: VPC, IAM, EKS, and EC2.

                         AWS Region (<region>)
 +----------------------------------------------------------+
 |  VPC                                                      |
 |                                                           |
 |   Public subnets            Private subnets               |
 |   +----------------+       +-------------------------+    |
 |   | Internet GW    |       | EKS managed node group  |    |
 |   | NAT Gateway    | <---- | (EC2 worker nodes)      |    |
 |   +----------------+       +-------------------------+    |
 |                                      |                    |
 |                         EKS control plane (managed)       |
 +----------------------------------------------------------+
   IAM roles: EKS cluster role, node group role (least privilege)







   What it provisions
Module	Resources
vpc	VPC, public and private subnets, Internet Gateway, NAT Gateway, route tables
iam	IAM roles and policy attachments for the EKS control plane and worker nodes
eks	EKS cluster and managed node group with configurable EC2 instance types and autoscaling settings
ec2	<describe what this module creates>

Worker nodes are placed in private subnets, following AWS security best practices.

Project structure

Adjust this to match your repository.

.
├── modules/
│   ├── vpc/
│   ├── iam/
│   ├── eks/
│   └── ec2/
├── environments/
│   ├── <env-1>/
│   ├── <env-2>/
│   └── <env-3>/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
Prerequisites
An AWS account and an IAM user or role with permission to create the resources above
Terraform <version> or later
AWS CLI, configured with aws configure
kubectl
Usage
Clone the repository and go into the environment folder:
bash
git clone <your-repo-url>
cd <repo>/environments/<env-name>
Initialize, format, validate, and plan:
bash
terraform init
terraform fmt
terraform validate
terraform plan
Review the plan, then apply:
bash
terraform apply

A full environment build takes about 5 to 10 minutes using this workflow.

Configure kubectl access to the cluster:
bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
kubectl get nodes
Configurable variables
Variable	Description	Example
region	AWS region	<ap-south-1>
instance_types	EC2 instance types for the node group	["t3.medium"]
desired_size / min_size / max_size	Node group autoscaling settings	2 / 1 / 4
<other>	<description>	<value>

Change values in the environment's variables file instead of editing module code.

Outputs

<List your outputs, for example: cluster name, cluster endpoint, VPC ID, subnet IDs>

Kubernetes components

The cluster uses VPC CNI, CoreDNS, and kube-proxy. Managing these through EKS managed add-ons is planned as the next improvement.

Cost warning

NAT Gateways and EKS clusters incur charges while they exist. Destroy the environment when you finish:

bash
terraform destroy
Security notes
Worker nodes run in private subnets
IAM roles follow least privilege
Never commit terraform.tfstate, .tfvars files with secrets, or AWS credentials. Add them to .gitignore
What I learned
Structuring Terraform into reusable modules with variables, outputs, and dependencies
How VPC networking, NAT Gateways, and IAM fit together for EKS
Using terraform fmt, validate, and plan before every apply to catch mistakes early
Future improvements
Manage VPC CNI, CoreDNS, and kube-proxy through EKS managed add-ons
Add remote state with S3 and DynamoDB locking
Add a GitHub Actions pipeline to run fmt, validate, and plan on every pull request
Author

Sankuri Syam Prasad Mukharjee Babu GitHub: github.com/sankurisyam | LinkedIn: linkedin.com/in/s-syam-babu
