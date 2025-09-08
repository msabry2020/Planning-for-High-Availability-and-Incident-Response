# Infrastructure

## AWS Zones
Identify your zones here

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

- Deploy Terraform infrastructure code to both primary and DR regions to ensure the following:
- 3 EC2 instances are up and running in the DR region using the same custom AMI.
- SSH access is configured and tested for accessing the web servers.
- Application Load Balancer (ALB) is routing traffic correctly to the DR EC2 instances.
- RDS cluster is deployed with 2 nodes (writer and reader) and configured for replication.
- Kubernetes cluster is deployed with Prometheus and Grafana configured for monitoring DR infrastructure.

## Steps:

1- Verify RDS replication status
2- Promote DR RDS instance to primary
3- Execute failover test and update application configuration (if needed) to point to the new DB endpoint.
4- Configure Route 53 to point to the DR region’s Application Load Balancer.
5- Test application connectivity after DNS change
6- Verify Web pages load correctly.
7- Verify Database connections are functional.
8- Monitoring dashboards reflect DR metrics 
9- Confirm the predefined SLIs/SLOs are met

## Timing & Validation Checklist

- Terraform DR deployment	~30–60 mins	(All resources created and running)
- RDS replication check 	~15-20 mins	(Replica is in sync and healthy)
- DNS update	            ~15–20 mins	(DNS resolves to DR ALB)
- Application test	        ~15-20 mins	(App loads, Test DB queries)
- Monitoring validation	    ~30    mins	(Metrics visible in Grafana and SLI/SLOs are met)