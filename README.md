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

⏰ **Deadline:** Submit on or before **loading...**.  
