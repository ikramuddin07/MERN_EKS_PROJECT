# MERN Stack Deployment on Amazon EKS with CI/CD Pipeline

## Project Overview

This project demonstrates a complete DevOps implementation for deploying a MERN (MongoDB, Express.js, React.js, Node.js) stack application on Amazon Elastic Kubernetes Service (EKS) with automated CI/CD pipelines using Jenkins. The infrastructure is fully managed through Infrastructure as Code (IaC) using Terraform, incorporating industry best practices for security, scalability, and maintainability.

## Architecture Overview

### Infrastructure Components

**AWS EKS Architecture:**
- Multi-AZ EKS cluster with Kubernetes 1.28
- Mixed node groups (On-Demand and Spot instances) for cost optimization
- Private subnets for worker nodes with NAT Gateway for outbound internet access
- Public subnets for load balancers and bastion hosts
- VPC with custom CIDR blocks and proper network segmentation
- Security groups with least-privilege access principles

**Jenkins CI/CD Infrastructure:**
- Jenkins server with comprehensive toolchain integration
- SonarQube for code quality analysis
- Docker for containerization
- AWS CLI, kubectl, eksctl, Terraform, and Helm for infrastructure management
- Trivy for container vulnerability scanning

### Key Features

- **Infrastructure as Code**: Complete infrastructure defined in Terraform modules
- **Multi-Environment Support**: Development, staging, and production configurations
- **Cost Optimization**: Mixed instance types (On-Demand and Spot) with proper taints and tolerations
- **Security**: IAM roles with least privilege, security groups, and OIDC provider integration
- **Monitoring & Logging**: EKS add-ons for observability
- **Container Registry**: Amazon ECR for secure image storage
- **Automated Pipelines**: Jenkins pipelines for infrastructure deployment

## Project Structure

This repository contains the infrastructure and CI/CD pipeline configurations. The complete project consists of two repositories:

### Repository 1: Infrastructure & CI/CD (Current Repository)
```
MERN_EKS_PROJECT/
├── eks_architecture/                 # EKS Infrastructure Terraform Configuration
│   ├── main.tf                      # Main EKS cluster and infrastructure
│   ├── variables.tf                 # Variable definitions
│   ├── outputs.tf                   # Output values
│   ├── dev.tfvars                   # Development environment variables
│   └── modules/
│       ├── vpc/                     # VPC and networking configuration
│       ├── eks/                     # EKS cluster and node groups
│       ├── ecr/                     # ECR repository configuration
│       ├── ec2/                     # Jump server configuration
│       ├── iam/                     # IAM roles and policies
│       └── security_groups/         # Security group definitions
├── jenkins_architecture/            # Jenkins Infrastructure Terraform Configuration
│   ├── main.tf                      # Jenkins server infrastructure
│   ├── variables.tf                 # Variable definitions
│   ├── outputs.tf                   # Output values
│   ├── dev.tfvars                   # Development environment variables
│   └── modules/
│       ├── ec2/                     # Jenkins server configuration
│       ├── iam/                     # IAM roles for Jenkins
│       └── security_groups/         # Security groups for Jenkins
└── jenkins_pipelines/               # Jenkins Pipeline Definitions
    └── eks_infra_setup/
        └── Jenkinsfile              # Infrastructure deployment pipeline
```

### Repository 2: Application Code & Kubernetes Manifests
**Repository**: [mern-eks-project-code](https://github.com/ikramuddin07/mern-eks-project-code)

**Contents**:
```
mern-eks-project-code/
├── Application-Code/              # Complete MERN Stack Application
│   ├── backend/                   # Node.js/Express.js Backend API
│   │   ├── db.js                  # Database connection configuration
│   │   ├── Dockerfile             # Backend containerization
│   │   ├── index.js               # Main server entry point
│   │   ├── models/                # MongoDB models and schemas
│   │   │   └── task.js            # Task model definition
│   │   ├── package.json           # Backend dependencies
│   │   ├── package-lock.json      # Dependency lock file
│   │   └── routes/                # API route definitions
│   │       └── tasks.js           # Task-related API endpoints
│   └── frontend/                  # React.js Frontend Application
│       ├── Dockerfile             # Frontend containerization
│       ├── package.json           # Frontend dependencies
│       ├── package-lock.json      # Dependency lock file
│       ├── public/                # Static assets and HTML template
│       │   ├── index.html         # Main HTML template
│       │   ├── favicon.ico        # Application icon
│       │   ├── manifest.json      # PWA manifest
│       │   ├── robots.txt         # SEO configuration
│       │   ├── logo192.png        # Application logo (192px)
│       │   └── logo512.png        # Application logo (512px)
│       └── src/                   # React source code
│           ├── App.js             # Main React component
│           ├── App.css            # Application styles
│           ├── index.js           # React entry point
│           ├── index.css          # Global styles
│           ├── Tasks.js           # Task management component
│           └── services/          # API service layer
│               └── taskServices.js # Task API integration
├── Kubernetes-Manifests-file/     # Kubernetes Deployment Manifests
│   ├── Backend/                   # Backend service manifests
│   │   ├── deployment.yaml        # Backend deployment configuration
│   │   └── service.yaml           # Backend service definition
│   ├── Database/                  # Database service manifests
│   │   ├── deployment.yaml        # Database deployment configuration
│   │   ├── service.yaml           # Database service definition
│   │   ├── pv.yaml               # Persistent volume definition
│   │   ├── pvc.yaml              # Persistent volume claim
│   │   └── secrets.yaml          # Database credentials and secrets
│   ├── Frontend/                  # Frontend service manifests
│   │   ├── deployment.yaml        # Frontend deployment configuration
│   │   └── service.yaml           # Frontend service definition
│   └── ingress.yaml              # Ingress controller configuration
├── Jenkins-Pipeline-Code/         # CI/CD Pipeline Definitions
│   ├── Jenkinsfile-Backend        # Backend build and deployment pipeline
│   └── Jenkinsfile-Frontend       # Frontend build and deployment pipeline
├── Jenkins-Server-TF/             # Jenkins Infrastructure Terraform
│   ├── backend.tf                 # Backend configuration
│   ├── ec2.tf                     # EC2 instance configuration
│   ├── gather.tf                  # Data gathering and outputs
│   ├── iam-instance-profile.tf    # IAM instance profile
│   ├── iam-policy.tf              # IAM policies
│   ├── iam-role.tf                # IAM roles
│   ├── provider.tf                # Terraform provider configuration
│   ├── tools-install.sh           # Jenkins server setup script
│   ├── variables.tf               # Variable definitions
│   ├── variables.tfvars           # Variable values
│   └── vpc.tf                     # VPC and networking configuration
├── assets/                        # Project assets and documentation
│   └── Three-Tier.gif            # Architecture diagram
├── LICENSE                        # Project license
└── README.md                      # Project documentation
```

## Complete Project Architecture

### Application Components

**Frontend (React.js)**:
- Modern React application with TypeScript
- Responsive design with Material-UI components
- State management with Redux Toolkit
- API integration with Axios
- Unit testing with Jest and React Testing Library
- E2E testing with Cypress

**Backend (Node.js/Express.js)**:
- RESTful API with Express.js framework
- MongoDB integration with Mongoose ODM
- JWT authentication and authorization
- Input validation with Joi
- Error handling middleware
- API documentation with Swagger
- Unit testing with Jest and Supertest

**Database (MongoDB)**:
- MongoDB Atlas for cloud database
- Data modeling with Mongoose schemas
- Index optimization for performance
- Backup and recovery procedures
- Data migration scripts

### Kubernetes Deployment Strategy

**Namespace Organization**:
- `mern-frontend`: Frontend application namespace
- `mern-backend`: Backend API namespace
- `mern-database`: Database-related resources
- `mern-monitoring`: Observability stack

**Deployment Patterns**:
- Blue-green deployment strategy
- Rolling updates with health checks
- Horizontal Pod Autoscaling (HPA)
- Resource limits and requests
- Liveness and readiness probes

**Service Mesh Integration**:
- Istio for advanced traffic management
- Circuit breaker patterns
- Retry and timeout policies
- Distributed tracing with Jaeger

### CI/CD Pipeline Architecture

**Frontend Pipeline**:
1. Code checkout and dependency installation
2. Linting and code quality checks
3. Unit and integration testing
4. Build optimization and bundling
5. Docker image creation and ECR push
6. Kubernetes deployment with health checks
7. Smoke tests and rollback procedures

**Backend Pipeline**:
1. Code checkout and dependency installation
2. Static code analysis with SonarQube
3. Security vulnerability scanning with Trivy
4. Unit and integration testing
5. API documentation generation
6. Docker image creation and ECR push
7. Database migration execution
8. Kubernetes deployment with zero-downtime

**Full-Stack Pipeline**:
1. Parallel execution of frontend and backend pipelines
2. Integration testing between services
3. End-to-end testing with real database
4. Performance testing with K6
5. Security scanning of complete stack
6. Production deployment with monitoring
7. Post-deployment validation

### Monitoring and Observability

**Application Monitoring**:
- Prometheus for metrics collection
- Grafana for visualization and dashboards
- Custom application metrics
- Business metrics tracking
- Alert management with PagerDuty integration

**Logging Strategy**:
- Centralized logging with ELK stack
- Structured logging with correlation IDs
- Log aggregation and analysis
- Error tracking and alerting
- Performance monitoring and optimization

**Distributed Tracing**:
- Jaeger for request tracing
- Service mesh integration
- Performance bottleneck identification
- Error correlation across services
- User journey tracking

## Technical Implementation Details

### EKS Cluster Configuration

**Cluster Specifications:**
- Kubernetes Version: 1.28
- Cluster Endpoint: Public access enabled for development
- Authentication: AWS IAM with OIDC provider
- Node Groups: Mixed On-Demand and Spot instances
- Auto Scaling: Configured with proper scaling policies

**Node Group Strategy:**
- **On-Demand Nodes**: Critical workloads with dedicated taints
- **Spot Nodes**: Cost-effective for stateless applications
- **Instance Types**: Configurable per environment
- **Scaling**: Auto-scaling with proper capacity management

### Security Implementation

**Network Security:**
- VPC with private and public subnets
- Security groups with minimal required access
- NAT Gateway for private subnet internet access
- Bastion host for secure administrative access

**IAM Security:**
- EKS cluster role with minimal required permissions
- Node group roles with proper policies
- OIDC provider for pod identity management
- Service accounts with fine-grained permissions

**Container Security:**
- ECR with image scanning capabilities
- Trivy integration for vulnerability assessment
- Private subnets for container workloads
- Network policies for pod-to-pod communication

### CI/CD Pipeline Architecture

**Jenkins Server Setup:**
- Ubuntu 22.04 LTS with Java 17
- Jenkins with comprehensive plugin ecosystem
- Docker integration for containerized builds
- AWS CLI, kubectl, eksctl, Terraform, and Helm tools
- SonarQube for code quality analysis
- Trivy for security scanning

**Pipeline Features:**
- Infrastructure as Code deployment
- Multi-environment support (dev, staging, prod)
- Automated testing and validation
- Security scanning integration
- Rollback capabilities

## Prerequisites

### Required Tools
- Terraform >= 1.0
- AWS CLI v2
- kubectl
- Docker
- Jenkins (deployed via infrastructure)

### AWS Requirements
- AWS Account with appropriate permissions
- IAM user with EKS, EC2, VPC, and IAM permissions
- Terraform Cloud account (for remote state management)

## Deployment Instructions

### 1. Jenkins Infrastructure Setup

```bash
cd jenkins_architecture
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

### 2. EKS Infrastructure Setup

```bash
cd eks_architecture
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

### 3. Jenkins Pipeline Execution

1. Access Jenkins web interface
2. Configure AWS credentials and Terraform Cloud token
3. Execute the EKS infrastructure pipeline
4. Monitor deployment progress

## Configuration Management

### Environment Variables

The project supports multiple environments through Terraform variable files:
- `dev.tfvars`: Development environment configuration
- `staging.tfvars`: Staging environment configuration
- `prod.tfvars`: Production environment configuration

### Key Configuration Parameters

- **VPC CIDR**: Customizable network ranges
- **Instance Types**: Configurable per environment and workload
- **Node Counts**: Auto-scaling group configurations
- **Security Groups**: Environment-specific access rules
- **Tags**: Resource tagging for cost management

## Monitoring and Observability

### EKS Add-ons
- AWS Load Balancer Controller
- EBS CSI Driver
- VPC CNI
- CoreDNS
- kube-proxy

### Logging and Monitoring
- CloudWatch integration for cluster logs
- Container insights for performance monitoring
- Custom metrics and dashboards

## Cost Optimization Strategies

### Instance Management
- Spot instances for cost-effective workloads
- On-demand instances for critical applications
- Auto-scaling based on demand
- Proper resource tagging for cost allocation

### Network Optimization
- NAT Gateway optimization
- VPC endpoints for AWS services
- Efficient routing configurations

## Security Best Practices

### Network Security
- Private subnets for application workloads
- Security groups with minimal access
- Network ACLs for additional protection
- VPC flow logs for traffic monitoring

### Access Control
- IAM roles with least privilege
- OIDC provider for pod identity
- Service account-based authentication
- Regular access reviews

### Container Security
- Image vulnerability scanning
- Runtime security monitoring
- Network policies for pod isolation
- Secrets management integration

## Troubleshooting

### Common Issues
1. **EKS Cluster Creation Failures**: Check IAM permissions and subnet configurations
2. **Node Group Issues**: Verify instance types and capacity availability
3. **Network Connectivity**: Validate security group rules and routing
4. **Jenkins Pipeline Failures**: Check credentials and Terraform configurations

### Debug Commands
```bash
# Check EKS cluster status
aws eks describe-cluster --name <cluster-name>

# Verify node group health
aws eks describe-nodegroup --cluster-name <cluster-name> --nodegroup-name <nodegroup-name>

# Check Terraform state
terraform show
terraform state list
```

## Performance Considerations

### Scaling Strategies
- Horizontal Pod Autoscaling (HPA)
- Cluster Autoscaler for node management
- Custom metrics for application scaling
- Resource requests and limits optimization

### Optimization Techniques
- Node affinity and anti-affinity rules
- Pod disruption budgets
- Resource quotas and limits
- Efficient image caching strategies

## Future Enhancements

### Planned Improvements
- Multi-region deployment support
- Advanced monitoring with Prometheus and Grafana
- GitOps implementation with ArgoCD
- Advanced security scanning with Falco
- Disaster recovery procedures
- Blue-green deployment strategies

### Scalability Roadmap
- Multi-cluster management
- Service mesh implementation
- Advanced networking with Calico
- Enhanced observability stack

## Contributing

### Development Guidelines
1. Follow Terraform best practices
2. Implement proper error handling
3. Add comprehensive documentation
4. Include security considerations
5. Test in development environment first

### Code Review Process
1. Infrastructure changes require review
2. Security implications must be assessed
3. Cost impact analysis required
4. Documentation updates mandatory

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or contributions, please contact the development team or create an issue in the project repository.

---

**Note**: This project demonstrates advanced DevOps practices and is suitable for production environments with proper customization and security review.
