## Automate Deployment with Terraform and Ansible - Full Stack Application with Monitoring and Logging

This project focuses on automating the deployment of a full-stack application and its associated monitoring and logging infrastructure using Terraform and Ansible. The workflow ensures seamless provisioning, configuration, and deployment of application and monitoring stacks with path-based routing, SSL certificate management, and DNS updates.

Key improvements over previous iterations include full automation of infrastructure and deployment processes. The same application source code from Week 1 is utilized, but the setup is fully automated to reduce manual intervention and enhance scalability and reproducibility.

## Objectives

Automate infrastructure provisioning using Terraform to manage compute, networking, and DNS resources on AWS.
Streamline application and monitoring stack deployment using Ansible, organized into modular roles (e.g., application, database, monitoring, Traefik, nginx, common).
Ensure secure routing with Traefik, including SSL certificate issuance and DNS A-record updates for public IPs.
Use prebuilt Docker images for the application stack, stored in Docker Hub, for faster deployments.
Provide a single command deployment workflow:

```
terraform apply --auto-approve
```
![diagram](images/diagram.png)

### **Components** 
--- 
#### **1. Infrastructure Provisioning (Terraform)**

- **Compute Resources**: AWS EC2 instances for hosting the application and monitoring stacks.
- **Networking Resources**: Configures VPC, subnets, security groups, and internet gateways.
- **DNS Management**: Adds A-record entries in AWS Route53 pointing to EC2 public IPs.
- **Integration with Ansible**:
  1. Dynamically generates inventory.ini files.
  2. Triggers Ansible playbooks post-provisioning.

#### **2. Application Stack**
- **Frontend:** React-based user interface.
- **Backend:** FastAPI for handling API requests.
- **Database:** PostgreSQL for persistent data storage.
- **Reverse Proxy:** Traefik for path-based routing between services and SSL management.

> You must prebuild the Docker images for the **Frontend** and **Backend** and push them to your public Docker Hub repositories:
Reference: We built docker images and pushed that to DockerHub in https://github.com/kapilkumaria/cv-challenge01

- Example frontend image: `docker.io/<your_username>/frontend:latest`  
- Example backend image: `docker.io/<your_username>/backend:latest`  

The application stack Ansible role will pull these images from Docker Hub.

---

#### **3. Monitoring Stack**
- **Prometheus** Collects and stores application metrics.
- **Grafana** Provides visualizations with preconfigured dashboards for cAdvisor and Loki.
- **cAdvisor** Monitors container-level metrics.
- **Loki** Aggregates logs from the application and system.
- **Promtail** Collects logs from the application and system.
---

#### **4. Deployment Workflow**
- **Terraform:**  
  - Provisions the cloud infrastructure (e.g., server instance, networking).
  - Generates the Ansible inventory file (`inventory.ini`) dynamically.  
  - Triggers Ansible playbooks.  

- **Ansible:**  
  - Configures the server environment.  
  - Creates a shared Docker network.  
  - Deploys the application and monitoring stacks by pulling prebuilt images from Docker Hub and running them via Docker Compose.  
  - Configures Traefik or Nginx for routing across all services.

---

## Project Structure

The project is organized into the following structure:

- ansible/: Contains playbooks, inventory files, and modular roles for deploying the application and monitoring stacks. Each role is designed to handle specific components, ensuring reusability and clarity.

- terraform/: Contains the configuration files for provisioning cloud infrastructure. It automates the creation of compute instances, networking resources, and DNS configurations.

---

```
~/cv-challenge-02 main !2 ❯ tree -L 2                                                                
.
├── README.md                       # Main documentation file for the repository.
├── ansible                         # Contains Ansible configurations and playbooks for deploying the application stack.
│   ├── README.md            
│   ├── ansible.cfg          
│   ├── group_vars           
│   ├── inventory            
│   ├── roles                
│   ├── site.yml             
│   └── vault                
├── ansible.cfg -> /home/ubuntu/cv-challenge-o2/ansible/ansible.cfg
├── images                   
│   └── ansible-folders.png  
└── terraform                       # Contains Terraform configurations for infrastructure provisioning.
    ├── backend              
    ├── backend.tf           
    ├── environments         
    ├── main.tf              
    ├── modules              
    ├── outputs.tf           
    └── variables.tf         
```
---

```
ansible/
├── README.md                       # Documentation for the Ansible setup, including instructions on usage and configuration.
├── ansible.cfg                     # Ansible configuration file to define defaults (e.g., inventory file, SSH user).
├── group_vars                      # Directory for group-specific variables (e.g., variables for all application servers).
├── inventory                       # Inventory file defining groups of servers (e.g., dev, prod) and their IPs/hostnames.
├── roles                           # Directory containing modular roles for specific components.
│   ├── application                 # Role to deploy and configure the application stack (frontend, backend).
│   │   ├── defaults                # Default variables for the role (can be overridden by other variable files).
│   │   ├── files                   # Static files used in the application setup.
│   │   │   ├── backend.env         # Environment file for backend configuration (e.g., DB connection, API keys).
│   │   │   ├── frontend.env        # Environment file for frontend configuration (e.g., API URLs, environment).
│   │   │   └── nginx.conf          # Nginx configuration file for routing and load balancing.
│   │   ├── handlers                # Handlers triggered by tasks (e.g., restart services after configuration changes).
│   │   ├── meta                    # Metadata about the role (e.g., dependencies, author, etc.).
│   │   ├── tasks                   # Directory containing task files that define actions to configure the application.
│   │   │   └── main.yml            # Main task file to deploy and configure the application stack.
│   │   ├── templates               # Jinja2 templates to dynamically generate configuration files.
│   │   │   └── docker_container.j2 # Template for Docker Compose or container definitions.
│   │   └── vars                    # Variables specific to the application role.
│   ├── common                      # Role for common configurations and dependencies shared across all roles.
│   │   └── tasks
│   │       └── main.yml            # Main task file for common setup actions (e.g., installing packages, creating users).
│   ├── db                          # Role for setting up the database.
│   │   ├── files
│   │   │   └── db.env              # Environment file for database configuration (e.g., credentials, connection settings).
│   │   └── tasks
│   │       └── main.yml            # Main task file for database setup and configuration.
│   ├── monitoring                  # Role for setting up the monitoring stack (Prometheus, Grafana, Loki, etc.).
│   │   ├── files                   # Static configuration files for monitoring services.
│   │   │   ├── grafana.yml         # Configuration file for Grafana.
│   │   │   ├── loki-config.yml     # Configuration file for Loki (log aggregation).
│   │   │   ├── prometheus.yml      # Configuration file for Prometheus (metrics collection).
│   │   │   └── promtail-config.yml # Configuration file for Promtail (log forwarding).
│   │   ├── handlers                # Handlers for monitoring services (e.g., restart Prometheus, reload Grafana).
│   │   ├── tasks
│   │   │   └── main.yml            # Main task file for setting up and configuring monitoring tools.
│   │   └── templates               # Templates for monitoring service configurations (optional).
│   ├── nginx                       # Role for configuring and deploying Nginx as a reverse proxy or load balancer.
│   │   ├── files
│   │   │   └── nginx.conf          # Static Nginx configuration file.
│   │   └── tasks
│   │       └── main.yml            # Main task file for Nginx setup.
│   └── traefik                     # Role for setting up Traefik as a reverse proxy and SSL manager.
│       ├── defaults                # Default variables for Traefik configuration.
│       ├── files
│       │   └── acme.json           # File to store SSL certificates managed by Traefik.
│       ├── handlers                # Handlers for Traefik (e.g., restart after config changes).
│       ├── tasks
│       │   └── main.yml            # Main task file for Traefik setup and configuration.
│       ├── templates               # Templates for Traefik configurations (optional).
│       └── vars                    # Variables specific to the Traefik role.
├── site.yml                        # Master playbook to orchestrate all roles and tasks.
└── vault                           # Directory for encrypted secrets using Ansible Vault.
```
---

```
terraform/
├── backend                   # Directory for backend-specific Terraform configuration (remote state storage)
│   ├── main.tf               # Defines S3 bucket and DynamoDB table for Terraform remote backend state.
│   ├── outputs.tf            # Outputs for backend resources (e.g., S3 bucket name and DynamoDB table name).
│   └── variables.tf          # Input variables for backend configuration (e.g., bucket name, region).
├── backend.tf                # Configures Terraform to use the remote backend created in `backend/main.tf`.
├── environments              # Directory for environment-specific variable files (e.g., dev, prod).
│   ├── dev.tfvars            # Variable definitions specific to the development environment.
│   ├── prod.tfvars           # Variable definitions specific to the production environment.
│   └── staging.tfvars        # Variable definitions specific to the staging environment.
├── main.tf                   # Main Terraform configuration file to orchestrate infrastructure provisioning.
├── modules                   # Directory containing reusable Terraform modules.
│   ├── compute               # Module to manage compute resources (e.g., EC2 instances).
│   │   ├── main.tf           # Defines compute resources (e.g., EC2 instances, ASGs).
│   │   ├── main.tf.bkp       # Backup of an earlier version of `main.tf` (optional; consider removing).
│   │   ├── outputs.tf        # Outputs specific to compute resources (e.g., public IP, instance ID).
│   │   ├── provider.tf       # Specifies provider configuration (e.g., AWS region, credentials).
│   │   ├── variables.tf      # Input variables for compute module.
│   │   └── variables.tf.bkp  # Backup of an earlier version of `variables.tf` (optional; consider removing).
│   └── network               # Module to manage networking resources (e.g., VPC, subnets).
│       ├── main.tf           # Defines networking resources (e.g., VPC, subnets, gateways).
│       ├── outputs.tf        # Outputs specific to networking resources (e.g., VPC ID, subnet IDs).
│       └── variables.tf      # Input variables for networking module.
├── outputs.tf                # Outputs for the main Terraform configuration (e.g., public IP, DNS name).
└── variables.tf              # Input variables for the main Terraform configuration.
```
![docs](images/docs.png)
![redoc](images/redoc.png)
![prometheus](images/prometheus.png)
![grafana1](images/grafana1.png)
![grafana2](images/grafana2.png)
![grafana3](images/grafana3.png)

# How to Use This Repository

Follow the steps below to set up and deploy the services defined in this repository:

### Step 1: AWS - EC2 Instance Ubuntu, t2.medium with 50GiB Storage Volume

### Step 2: Install these Packages
- Update System Packes
- Git
- Docker
- Docker Compose
- Terraform
- Ansible
- AWS CLI
- Tree (Optional)

### Step 3: Clone the Repository

Clone this repository to your server to access the application and configuration files.
```
git clone https://github.com/kapilkumaria/cv-challenge-02.git
```
### Step 4: Navigate to the Terraform Directory

Move into the application folder where the main docker-compose.yml file is located.
```
cd cv-challenge-02/terraform
```

### Step 5: Create an AWS Profile

Set up an AWS CLI profile to manage credentials and region configurations:
```
aws configure --profile=<profile-name>

# Replace <profile-name> with a unique name for your profile (e.g., terraform-profile).

```
Update the provider block in terraform/main.tf to use the newly created AWS profile:

```
provider "aws" {
    profile = "<profile-name>"   # Replace with the profile name you configured
}

```
### Step 6: Set Up the Remote Backend

Navigate to the terraform/backend directory.
Run the following commands to create an S3 bucket for storing the Terraform state file remotely and a DynamoDB table for state locking:
```
cd terraform/backend
terraform init      # Initialize the backend configuration
terraform plan      # Preview the changes to be applied
terraform apply     # Apply the changes to create S3 bucket and DynamoDB table

# Note: (Optional) Replace 'S3 bucket name', 'DynamoDB table name' and 'IAM policy for terraform backend access in terraform/backend/main.tf'
```
### Step 7: Configure Terraform Backend to Use Remote S3 for State Management

Navigate to the root terraform/ directory.

Run the following commands to switch Terraform state management from local to remote using the S3 bucket and DynamoDB table created earlier:

```
cd terraform
terraform init      # Reinitialize with the remote backend
```

### Step 8: Copy <aws.pem> File to Your Home Directory

Use the scp command to securely copy your .pem file (AWS key pair) to the home directory of the server where Terraform will be executed:
```
scp -i <aws.pem> <aws.pem> ubuntu@<server_ip>:/home/ubuntu

# Replace <aws.pem> with the name of your key pair file.
# Replace <server_ip> with the public IP address of your server.
```
```
# Ensure that Git does not track this .pem file to avoid security risks:

git update-index --assume-unchanged <path-to-aws.pem>
```

### Step 9: Update Security Group Rules in variables.tf

Open the file located at terraform/modules/compute/variables.tf.

Update the security group rules as follows:
    Port 22 (SSH): Set the CIDR block to your IP address for secure SSH access.
    Port 22 (Server/Host): Set the CIDR block to the IP address of the server/host where Terraform is running.

  Example configuration:
```
variable "security_group_rules" {
    default = [
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["<your-ip>/32"]   # Replace <your-ip> with your local IP address
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["<server-ip>/32"]  # Replace <server-ip> with the server/host IP
        }
    ]
}

# Save the changes and proceed with your Terraform steps.
```
### Step 10: Deploy the Complete Infrastructure and Application for the Dev Environment

Execute the following command to provision the infrastructure and deploy the application for the development environment:
```
terraform apply --var-file=environments/dev.tfvars --auto-approve
```
> This command automates the following:

  1. Infrastructure Provisioning:
        - Terraform will provision AWS network resources (e.g., VPC, subnets).
        - Terraform will provision AWS compute resources (e.g., EC2 instances).
  2. Application Deployment:
        Terraform will trigger Ansible to:
        - Deploy the full application stack (frontend, backend, database).
        - Deploy the monitoring stack (Prometheus, Grafana, Loki, etc.).
        - Configure Traefik for path-based routing and SSL management.

Once completed, the infrastructure and application will be fully deployed and operational.

### Step 11: Test Your Application and Verify the Deployment

Verify the following components to ensure the deployment was successful:
1. **Application Accessibility**: 
  
     1.1 Check if the application is accessible through the reverse proxy.
     
     1.2 Monitoring Dashboards: Confirm that the monitoring dashboards in Grafana are displaying metrics, including: 
     
      1.2.1 cAdvisor: Container-level metrics.
     
      1.2.2 Loki: Logs from the application and infrastructure.

## Access the application and services using the following URLs:
   
   **Application Root**: `https://<your-domain>/`
   
   **API Documentation (Swagger)**: `https://<your-domain>/docs`
   
   **API Documentation (ReDoc)**: `https://<your-domain>/redocs`

   **Database Admin Interface (Adminer)**: `https://<your-domain>/adminer`

   **Prometheus Metrics**: `https://<your-domain>/prometheus`

   **Grafana Dashboards**: `https://<your-domain>/grafana`

   Examples:

   https://boss.kapilkumaria.com

   https://boss.kapilkumaria.com/docs

   https://boss.kapilkumaria.com/prometheus

## Additional Features:
  1. **Automatic Redirect to HTTPS**:

        This setup ensures that all traffic to `http://www.<your-domain>` is redirected to `https://<your-domain>.com`
        
  2. **SSL Certificate Issuance**:

        Traefik will automatically issue and manage SSL certificates for your domain, ensuring secure communication.

  3. Replace `<your-domain>` with the actual domain name configured in your deployment.