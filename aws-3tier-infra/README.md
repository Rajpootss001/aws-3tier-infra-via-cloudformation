# AWS 3-Tier Architecture Infrastructure (CloudFormation)

## 1. Overview

This repository provides a **modular, production-grade 3-tier architecture on AWS** using **nested CloudFormation stacks**.
The design follows industry standards for **scalability, high availability, security, and maintainability**.

The infrastructure is organized into logical layers:

* Network
* Security
* Load Balancing
* Compute
* Database

---

## 2. Architecture Overview

![Image](https://images.openai.com/static-rsc-4/MQi-B0ExP8-d9d3VFEwJVRLiZP48UDWA5s--KZEMOP4CQQzpCYd7ON6wF5Jo5sPdro0_rjUwU5Yx34jRvy20xYNbR1kYwLbHqKhhMFOZfFUmKglmsCqKDybZVCEgJGBnYVi-yctQqbqYpBUJ9Mt489cgqB9PyH0JqR-HbGU25BcNGobcWRh2DfE4EJhTOVV4?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/pYjCx72bW-ts3s5lR_htGOkQGcSTla_BmINekf5hH-xTr4JsWFFjyO8VaXGjDEKmUbyM2qcIBqZbRdYIkcx7pIyoVeWb6qkZeQ4OhtowcNel0JmfuMAXNY2dIsNqLwvIRQOlndr0im4o0lveJp_23fFoLqxxEiaIg36Aat41F9UWUczYUSrfoEd0SJKdMY83?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/w3KrFFQqe771Me-z_Q5rVu7jLF6xYoGABTiPRp0dbJHIfLRpXUVs4pXr26Y6VrZAmRv4tHqfLYiQcZ9pr52yVsx2tewxRvytpYQwx6ZQbhn0BJfMGVerOG_oalDMMdv96nDLvIaQsthx8W_cvLJ9W4zGuuUOBSHEJ0PZshwfNRJXdfUbh5t5MRvpXcH2rTKh?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/aQVK-IR2Icszcbk9D1nchxsDSrZ5-9JdbCZAQBMzqqgPNZfrihHSmBtnjxg9SpGGdP03nMVLy0AzWiz8bPD6RFjPbmpcnxmuBX59BWxuFXXaut3OETzHElImrIFZFTA43d4oWkKqRaD9Onrcy3YIprSbVIHJha8tzUzo3aUs30T3Xt9NSxxjbcPL4yFMCYBI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/9XAAQK7kTSGEQ8Pp5iJNtYQdTH6MNorBiyY2JZQBVOGGfAJw25XzVmeXEMo1BMI5db44eyBlSbvi2TetJzVjljOHcfZYvH8FAnB3j3cyk7XThNNcZ3gWxy7VbC8XEB0pI025LONmNGPrl_34qDJHx-LFR1EIYCsfYBPsKuiQ3GZDB9igJNDkh9wMj1kcy4jS?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/w_tHsYVgnxnwLyFWJ11V7nNVpIFY9fwZyYT1aPLDVrXluOuyT9nlwIuYkU-UKjyfitOZBRRYPJjEa7CY-a4L33qxAcvbHCfuuaZ5iAz_5MrO-g-ld_FSw_LbFtlGjvcAp4reduVNeSm-3IeM5imPwHPaIqatbktUblGygJ5Aa43doCoELmM4rYXVm2JI9iu2?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/zilDOcPZMQKzXAHqVTRU41dt1IUW37K593ok74T4Jc9YOmju7SXCw4bVEJk4X_5WoWXXyENJZ99kiPcvJeVyJIbA9eRBJ_a4INB9iuByyJpyKeXUGeidQlMCX9WdE1HgO-n411oSamuFDHxLKlCEc_J-GInlp8-oLnM7715sbGNv1xUe14qxOnDxa08bzll3?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/RC9IMU5Ml3SwnTQM4fyAM4FgA6zNS_mRKvhmcYP7KoO7xOu8prhYzfEI0vxxqo3-JEbrnTRCXMkpXtZXWwrMUiFM9ga5yZSyYQJHXgZZt0ve8fe1lkq_fWKkFYowbz4hPbVPxslUftK4aTPvj7B61DFybFojEauKIJKkbmTCgiXZDDZi4xT8FoxKravRg0Xb?purpose=fullsize)

### Architecture Layers

**Presentation Layer (Public Subnets)**
Handles incoming client traffic via an internet-facing load balancer.

**Application Layer (Private Subnets)**
Processes business logic using EC2 instances managed by an Auto Scaling Group.

**Database Layer (Private Subnets)**
Stores persistent data using a managed relational database service.

### Traffic Flow

Client → Load Balancer → Application Tier → Database Tier

---

## 3. Repository Structure

```bash
aws-3tier-infra/
│
├── templates/
│   ├── network/          # VPC, Subnets, IGW, NAT, Route Tables
│   ├── security/         # Security Groups
│   ├── loadbalancer/     # ALB, Listener, Target Groups
│   ├── compute/          # Launch Template, Auto Scaling Group
│   ├── database/         # RDS configuration
│   └── main.yaml         # Root stack (orchestration)
│
├── parameters/
│   └── prod.json         # Environment configuration
│
└── deploy.sh             # Deployment script
```

---

## 4. Deployment

### 4.1 Prerequisites

* Configured AWS CLI
* IAM permissions for:

  * CloudFormation
  * EC2
  * VPC
  * RDS
  * Auto Scaling

### 4.2 Deployment Command

```bash
bash deploy.sh
```

Or:

```bash
aws cloudformation deploy \
  --template-file templates/main.yaml \
  --stack-name prod-3tier \
  --parameter-overrides file://parameters/prod.json \
  --capabilities CAPABILITY_NAMED_IAM
```

---

## 5. Configuration Management

Environment-specific configurations are defined in:

```
parameters/prod.json
```

This approach ensures:

* Consistent deployments across environments
* Separation of configuration from infrastructure code
* Reusability of templates

---

## 6. Component Description

### 6.1 Network Layer

* Virtual Private Cloud (VPC)
* Public and Private Subnets across Availability Zones
* Internet Gateway (IGW)
* NAT Gateway for outbound private traffic
* Route Tables

### 6.2 Security Layer

* Security groups enforcing least-privilege access
* Controlled communication between tiers:

  * ALB → EC2
  * EC2 → RDS

### 6.3 Load Balancing

* Application Load Balancer (ALB)
* Target groups for traffic routing
* Listener configuration

### 6.4 Compute Layer

* EC2 Launch Template
* Auto Scaling Group for elasticity and fault tolerance

### 6.5 Database Layer

* Managed relational database instance
* Deployed in private subnets

---

## 7. Security Considerations

* No direct internet access to application or database layers
* Database restricted to application layer access only
* Recommended to externalize credentials using:

  * AWS Secrets Manager

---

## 8. Scalability and Availability

* Horizontal scaling via Auto Scaling Group
* Load balancing across multiple instances
* Multi-AZ subnet distribution for resilience

---

## 9. Limitations

* HTTPS is not configured
* DNS routing is not included
* Monitoring and alerting are not implemented
* Database credentials are statically defined

---

## 10. Recommended Enhancements

* Enable TLS/SSL using AWS Certificate Manager
* Add DNS management via Amazon Route 53
* Implement monitoring using Amazon CloudWatch
* Integrate CI/CD pipelines using AWS CodePipeline
* Use parameter store for configuration management

---

## 11. Cleanup

```bash
aws cloudformation delete-stack --stack-name prod-3tier
```

---

## 12. Maintenance Notes

* Update AMI IDs based on region
* Regularly rotate credentials
* Validate templates before deployment:

  ```bash
  aws cloudformation validate-template --template-body file://templates/main.yaml
  ```
* Monitor stack events during deployment

---
