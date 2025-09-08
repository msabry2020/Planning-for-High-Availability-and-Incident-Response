# Infrastructure

## AWS Zones
Primary: ["us-east-2a","us-east-2b"]
DR: ["us-west-1a", "us-west-1c"]

## Servers and Clusters

### Table 1.1 Summary
| Asset              | Purpose                             | Size                | Qty        | DR                                                   |
|--------------------|-------------------------------------|---------------------|------------|------------------------------------------------------|
| EC2 Instances      | Host the web application            | t3.micro            | 3          | Create 3 DR Web Instances                            |
| AMI Images         | Base image for EC2 instances        | N/A                 | 1          | Store AMI Image in DR region                         |
| SSH Keys           | Secure access to EC2 instances      | N/A                 | 1          | Seperate key for DR Web Instances and Stored locally |
| GitHub Repository  | Stores Terraform code               | N/A                 | 1          | Github Repo has a local copy                         |
| RDS Cluster        | Backend database                    | db.t3.medium        | 2 nodes    | Replicated in DR                                     |
| S3 Buckets         | Store Terraform state file          | N/A                 | 1          | Seperate S3 bucket for DR                            |
| Load Balancer      | Distribute traffic to web instances | N/A                 | 1          | Create LB in DR                                      |
| Kubernetes Cluster | Hosts monitoring tools              | t3.medium (compute) | 2 nodes    | Create EKS cluster in DR                             |
| Grafana            | Monitoring dashboard                | N/A                 | 1 instance | Create Grafana in DR                                 |
| Prometheus         | Collect Metrics                     | N/A                 | 1 instance | Create in DR                                         |

---

### Descriptions
EC2 Instances: 3 web servers running a custom AMI for the website. 
AMI Image: A custom AMI used to launch EC2 instances.                    
SSH Keys: Used by to securely access and manage EC2 instances.                 
GitHub Repository: Stores Terraform code for infrastructure deployment.                           
RDS Cluster: 2-node database cluster 
S3 Buckets: Used to store tfstate files for terraform
Application Load Balance: Distributes traffic across the 3 EC2 web servers.                              
Kubernetes Cluster: Hosts Grafana and Prometheus for monitoring.                                   

## DR Plan
### Pre-Steps:
Ensure the infrastructure is set up and working in the DR site.
1- 3 EC2 Instances are up and running
2- 3 EC2 Instances are accissable via ssh keys
3- LB routes the traffic correctly to the web instances
4- 2 Instances of RDS are working (writer and reader) 


## Steps:
1- Configure the DNS to point to the DR load balancer. 
2- Failover to the Secondary DB in DR site
