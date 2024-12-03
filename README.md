### Week 3: Automated CI/CD Pipelines for Infrastructure and Application  



This week, you’ll dive into building **CI/CD pipelines** for automating both infrastructure and application deployments, following GitOps principles. Through this challenge, you’ll gain hands-on experience with:  
- **Cloud cost optimization** using tools like InfraCost.  
- **GitOps workflows** for efficient and streamlined deployments.  
- **Git branching strategies** to separate development, integration, and production-ready code.  

---

### 💡 **What’s Included?**  

#### **Infrastructure Pipeline**  
- Use **Terraform** to provision the cloud infrastructure required for deploying the application.  
- **Branch Setup:**  
  - Use `infra_features` for making infrastructure changes.  
  - Open PRs to `infra_main` for reviews and approvals.  

- **Workflow Details:**  
  - **Push to `infra_features`:**  
    - Run `terraform validate` to ensure the configuration is error-free.  
  - **PR to `infra_main`:**  
    - Trigger `terraform plan` and output the plan as a comment in the PR.  
    - Include cost estimation (e.g., using InfraCost) to display monthly running costs.  
  - **Merge to `infra_main`:**  
    - Automatically run `terraform apply` with auto-approval to provision resources.  

#### **Application Pipeline**  
- You’ll be working with the **same three-tier application and monitoring stack** from Week 1.  
- **CI Pipeline (Integration Branch):**  
  - **Push to `integration`:**  
    - Build and tag Docker images for the app and monitoring stack.  
    - Push these images to a public Docker Hub repository.  
    - Update `docker-compose.yml` with the new image tags and commit the changes.  

- **CD Pipeline (Deployment Branch):**  
  - **Merge from `integration` to `deployment`:**  
    - Deploy the application and monitoring stack to the provisioned cloud infrastructure using the updated `docker-compose.yml`.  

#### **Workflow File Structure**  
Each pipeline should have its own `.yml` file:  
- `terraform-validate.yml`  
- `terraform-plan.yml`  
- `terraform-apply.yml`  
- `ci-application.yml`  
- `cd-application.yml`  

---

### 📋 **Requirements:**  

#### **Infrastructure Pipeline**  
- Automate validation, planning, and application of Terraform configurations.  
- Include cost estimation in the PR plan output.

**NOTE**: Your PR comment must contain cost estimation!!!

#### **Application Pipeline**  
- Ensure the CI pipeline in the `integration` branch:  
  - Builds and pushes Docker images to Docker Hub.  
  - Updates `docker-compose.yml` with the new image tags.  
- Ensure the CD pipeline in the `deployment` branch:  
  - Deploys the application and monitoring stack to the provisioned EC2 instance.  

---

### 📋 **Acceptance Criteria:**  

1. **Infrastructure Pipeline:**  
   - Successful validation, planning (with PR comments), and application workflows.  

2. **Application Pipeline:**  
   - CI pipeline builds images, pushes to Docker Hub, and updates `docker-compose.yml`.  
   - CD pipeline deploys the application and monitoring stack on the provisioned cloud infrastructure.  

3. **Workflow Organization:**  
   - Each pipeline should have a separate `.yml` file for clarity.  

---

### 📝 **Submission Instructions:**  
Submit your work via the **GitHub repository link**, including:  
1. Pipeline `.yml` files for both the infrastructure and application workflows.  
2. Terraform and Ansible configurations.  
3. A README detailing your approach, with an architectural diagram.  
4. Screenshots of successful execution for all pipelines (validate, plan, apply, build, and deploy).  

⏰ **Deadline:** Submit on or before **11:59 PM WAT, Sunday, 8th December 2024**.  

Let’s build together! 🚀 Questions? Ask away here!
