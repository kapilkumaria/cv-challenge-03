# Week 3: GitOps Workflow for Automation and Cost Optimization

This project introduces a comprehensive GitOps workflow designed to enhance automation and optimize costs. At its core, it implements GitOps principles by leveraging pull requests to facilitate code reviews, status checks, and discussions before applying any changes to the live infrastructure. The workflow employs fully automated CI/CD pipelines using GitHub Actions and features a robust branching strategy to manage infrastructure and application pipelines independently.

## Infrastructure Pipeline

Provisions and manages infrastructure using Terraform. Provides real-time cost analysis and optimization insights via Infracost. Triggers an Ansible workflow to configure servers and deploy a monitoring stack with dynamic dashboards, instantly accessible via custom domains.

## Application Pipeline

1. **CI pipelines**: Build Docker images for the application and update the deployment file (docker-compose.yml) with the latest image tag. Tags are structured using the workflow run number and short commit SHA for precise traceability (e.g., maestrops/backend:4-0a3087a).

2. **CD pipelines**: Deploy applications only after pull requests are merged, ensuring all changes are reviewed and approved. Post-deployment, applications are accessible through static configurations managed by Traefik.

## Security Enhancements

To maintain robust security: GitHub Actions repository secrets are used for managing sensitive variables. Environment files (.env) for applications are generated dynamically at runtime and securely destroyed after deployment.

## Key Improvements

This iteration emphasizes automation and cost optimization through a GitOps-centric approach. While it continues to utilize the same application source code from Weeks 1 and 2, this setup integrates:

- GitOps principles for streamlined workflows.
- Real-time cost estimation to enhance financial efficiency.
- Dynamic infrastructure and application management pipelines for better scalability and maintainability.

# Objectives

1. Implement GitOps Principles
   
   Utilize pull requests to enforce code reviews, discussions, and automated checks, ensuring high-quality changes before deployment.

2. Enhance Automation Across Pipelines
  
   Develop fully automated CI/CD pipelines to reduce manual intervention and improve workflow efficiency for infrastructure and applications.

3. Optimize Infrastructure Costs
   
   Integrate cost analysis and optimization tools, such as Infracost, to monitor and minimize infrastructure expenses proactively.

4. Streamline Deployment Processes
  
    Ensure seamless, traceable deployments by leveraging GitHub Actions, Docker image tagging, and Traefik for static configurations.

5. Strengthen Security Measures
   
   Use GitHub Actions repository secrets to protect sensitive data and dynamically generate and securely destroy application environment files.

6. Improve Monitoring and Observability
   
   Deploy a monitoring stack with dynamic, custom dashboards for real-time insights into application and infrastructure performance.

7. Promote Scalability and Maintainability
   
   Create independent pipelines for infrastructure and application management, enabling easy scalability and future enhancements.

8. Facilitate Cost-Effective Infrastructure Management
   
   Leverage Terraform and Ansible to automate provisioning and configuration while maintaining a focus on cost-effectiveness.



# Include Architecture Diagram here

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




























---------------------------------------------------------------------------
--------------------------------------------------------------------------


### Week 3: Automated CI/CD Pipelines for Infrastructure and Application  

This week, we’re focusing on building **CI/CD pipelines** to automate infrastructure and application deployments. Get ready to master:  
- **Cloud cost optimization** with cost estimation tools like InfraCost.  
- **GitOps workflows** for seamless automation.  
- **Terraform + Ansible integration** for infrastructure management and monitoring stack setup.  
- **Git branching strategies** for streamlined CI/CD pipelines.  

---

### 💡 **What’s Included?**  

#### **Infrastructure Pipeline**  
- Use **Terraform** to provision the cloud infrastructure required for the application.  
- Automatically trigger **Ansible** to set up the **monitoring stack** (Prometheus, Grafana, Loki, etc.).  

#### **Application Pipeline**  
- Continue working with the **three-tier application stack** from Week 1.  

---

### 🌲 **Branch Setup**  
You’ll work with the following branches:  

1. **Infrastructure Pipelines:**  
   - `infra_features`: Used for writing and testing Terraform changes.  
   - `infra_main`: Main branch for infrastructure.  

2. **Application Pipelines:**  
   - `integration`: Contains the CI pipeline for building and tagging images.  
   - `deployment`: Contains the CD pipeline for deploying the application stack.  

---

### 📋 **Workflow Details**  

#### **Infrastructure Pipeline**  
**Branches: `infra_features` → `infra_main`**  
- **Push to `infra_features`:**  
  - Run `terraform validate` to check the correctness of configurations.  
- **PR to `infra_main`:**  
  - Trigger `terraform plan`, output the plan as a comment in the PR, including cost estimation (e.g., using InfraCost).  
- **Merge to `infra_main`:**  
  - Run `terraform apply` with auto-approval to provision resources.  
  - Trigger Ansible to deploy the monitoring stack on the provisioned infrastructure.  

#### **Application Pipeline**  
**Branches: `integration` → `deployment`**  
- **Push to `integration`:**  
  - Build and tag Docker images for the application.  
  - Push images to a public Docker Hub repository.  
  - Update `docker-compose.yml` with the new image tags and commit the changes.  

- **Merge from `integration` to `deployment`:**  
  - Deploy the application stack to the provisioned infrastructure.  

---

### 📋 **Requirements:**  

#### **Infrastructure Pipeline**  
- Use Terraform to automate:  
  - Validation, planning (with PR comments), and applying configurations.  
  - Include cost estimation in the PR plan output as a required component.  
  - Trigger Ansible to deploy the monitoring stack after Terraform apply.  

#### **Application Pipeline**  
- **CI Pipeline (Integration Branch):**  
  - Build and push Docker images to Docker Hub.  
  - Update `docker-compose.yml` with the new image tags and commit the change to the Integration Branch.  
- **CD Pipeline (Deployment Branch):**  
  - Deploy the application stack to the cloud infrastructure.  

---

### 📋 **Acceptance Criteria:**  

1. **Infrastructure Pipeline:**  
   - Validation, planning (with PR comments, including cost estimation), and application workflows are functional.  
   - Ansible playbook is triggered to set up the monitoring stack after Terraform apply.  

2. **Application Pipeline:**  
   - CI pipeline builds images, pushes to Docker Hub, updates `docker-compose.yml` and commits the change.  
   - CD pipeline deploys the application stack to the cloud.  

3. **Workflow Organization:**  
   - Separate `.yml` files for each pipeline.
        - terraform-validate.yml
        - terraform-plan.yml
        - terraform-apply.yml
        - ansible-monitoring.yml
        - ci-application.yml
        - cd-application.yml

---

### 📝 **Submission Instructions:**  
Submit your work via the **GitHub repository link**, including:  
1. Link to your github repo containing both the infrastructure and application workflows.  
2. Terraform and Ansible configurations.  
3. Screenshots of successful execution for all pipelines.  
4. A **detailed blog post** documenting your process, including an **architectural diagram**.  
Here’s the updated README file with the link hidden behind text:  

---

⏰ **Deadline:** Submit on or before **Tuesday 11:59 PM**. [Submit Here](https://forms.gle/5UYV1usjnEJ1saS56).  
