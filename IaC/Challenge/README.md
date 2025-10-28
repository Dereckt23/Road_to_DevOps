# Challenge: DevOps — Multi-Tier Architecture on AWS

## Issue
This challenge focuses on building a **modern two-tier web application (Web and Application)** in the **AWS Cloud**, using **Terraform** to provision infrastructure and **Ansible** for configuration.  
The goal is to ensure **High Availability**, **Security**, and proper **Remote State Management** following DevOps best practices.

---

## Main Objectives of the Challenge

- **Terraform:** Provision a complete and secure infrastructure on AWS.  
- **Ansible:** Configure application servers in an automated and idempotent way.  
- **High Availability:** Deploy resources across multiple Availability Zones (AZs).  
- **Best Practice:** Use a remote backend in S3 with state locking for safe collaboration.

---

# Phase 1: Environment Setup and Remote State Management

The first and most critical step was to establish a collaborative, stable, and secure environment for remote Terraform state management.

### 1.1 Terraform Backend  
An **S3 bucket** was created to serve as the **remote backend** for Terraform.  
This bucket stores the Terraform state file, allowing multiple users to work on the same infrastructure without overwriting each other’s changes.

### 1.2 State Locking with DynamoDB  
To prevent state corruption from concurrent executions, a **DynamoDB table** was configured to handle state locking.  
This ensures that only one Terraform process can modify the state at a time.

### 1.3 Backend Configuration  
The main Terraform file (`main.tf`) was configured with the `backend "s3"` block, referencing the S3 bucket and DynamoDB table created earlier.  
This setup allows all team members to run the same Terraform commands while maintaining a **centralized and synchronized state**.

---

# Phase 2: Infrastructure Provisioning with Terraform

This phase involved building a **multi-tier, fault-tolerant architecture** as the foundation for the application.

### 2.1 Network and Subnets  
A custom **VPC** was provisioned with both **public and private subnets**, distributed across at least two Availability Zones.  
Public subnets host the Bastion and Web servers, while private subnets contain the Application servers.

### 2.2 Security Groups  
Strict **Security Groups** were defined for each layer:
- The **Web Tier** allows HTTP/HTTPS traffic from the internet.  
- The **App Tier** only allows inbound traffic from the Web Tier (port 8080).  
- The **Bastion Host** allows SSH access from authorized IP addresses.  

This segmentation ensures controlled communication between tiers.

### 2.3 Web Tier (Public Layer)  
Two **EC2 instances** were deployed in the public subnets, ensuring **High Availability** using `count` or `for_each`.  
These instances are responsible for serving static content or routing traffic.

### 2.4 Application Tier (Private Layer)  
Two **private EC2 instances** were deployed without public IPs.  
Access to these servers is restricted and only possible through the **Bastion Host**, which acts as a secure jump point.

### 2.5 Load Balancing (Optional)  
Optionally, an **Application Load Balancer (ALB)** was provisioned to distribute incoming traffic evenly across the Web Tier instances.

### 2.6 Metadata (Tags)  
Each instance was tagged with identifiers like `Tier: Web` or `Tier: App`.  
These tags play a crucial role in **Ansible’s dynamic inventory**, allowing automatic instance discovery without hardcoding IPs.

---

# Phase 3: Server Configuration with Ansible

In this stage, **Ansible** was used to automate the configuration and software setup of all servers, leveraging a dynamic inventory integrated with AWS.

### 3.1 Dynamic Inventory  
A dynamic inventory file (`inventories/app_aws_ec2.yml`) was created using the **`aws_ec2` plugin**.  
This inventory connects directly to the AWS API to fetch EC2 instance details using the tags defined by Terraform.  
As a result, Ansible dynamically detects and groups instances without the need for a static hosts file.

### 3.2 SSH Connection via Bastion Host  
One of the most challenging parts was configuring **SSH connectivity** to the private instances (App Tier) through the Bastion Host.  
Ansible was configured to use **ProxyJump**, establishing a secure SSH tunnel:
- The Bastion Host acts as the entry point.  
- The SSH key pair and user credentials are provided.  
- Traffic is forwarded automatically to the private instances.  

This setup enabled Ansible to run tasks inside private networks without exposing the servers to the public internet.

### 3.3 Web Tier Playbook  
A dedicated playbook was created for the Web Tier that:
- Installs a web server (Nginx or Apache).  
- Deploys a simple static web page.  
- Ensures the service is running and enabled (`state: started`, `enabled: yes`).  

The playbook is **idempotent**, meaning it can be executed multiple times without changing an already-correct configuration.

### 3.4 App Tier Playbook  
The second playbook focused on the **Application Layer**.  
It performs the following tasks:
- Installs the required runtime (e.g., Python or Node.js).  
- Deploys a simple demo application (e.g., a basic HTTP server).  
- Verifies that the service is running and accessible by the Web Tier.  

Playbooks were executed using:

```bash
ansible-playbook -i inventories/app_aws_ec2.yml playbooks/app-tier.yml
