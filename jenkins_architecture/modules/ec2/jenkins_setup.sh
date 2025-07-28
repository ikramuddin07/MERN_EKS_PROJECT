#!/bin/bash -xe

# Redirect all output to a log file for debugging
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

# Update and install base packages
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl wget gnupg lsb-release software-properties-common apt-transport-https unzip

# Get distro codename safely
. /etc/os-release
DISTRO_CODENAME=${UBUNTU_CODENAME:-$VERSION_CODENAME}

# -----------------------------------------------------------------------------
# Jenkins Installation
# -----------------------------------------------------------------------------
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y openjdk-17-jdk jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# -----------------------------------------------------------------------------
# Docker Installation
# -----------------------------------------------------------------------------
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $DISTRO_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add Jenkins and Ubuntu user to docker group
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# -----------------------------------------------------------------------------
# Sonarqube Docker Container
# -----------------------------------------------------------------------------
docker run -d  --name sonar -p 9000:9000 sonarqube:lts-community

# -----------------------------------------------------------------------------
# AWS CLI v2 Installation
# -----------------------------------------------------------------------------
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# -----------------------------------------------------------------------------
# kubectl Installation
# -----------------------------------------------------------------------------
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# -----------------------------------------------------------------------------
# eksctl Installation
# -----------------------------------------------------------------------------
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | \
  tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# -----------------------------------------------------------------------------
# Terraform Installation
# -----------------------------------------------------------------------------
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $DISTRO_CODENAME main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y terraform

# -----------------------------------------------------------------------------
# Helm Installation
# -----------------------------------------------------------------------------
curl https://baltocdn.com/helm/signing.asc | sudo gpg --dearmor -o /usr/share/keyrings/helm.gpg
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | \
  sudo tee /etc/apt/sources.list.d/helm-stable-debian.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y helm

# -----------------------------------------------------------------------------
# Trivy Installation
# -----------------------------------------------------------------------------
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
  gpg --dearmor -o /usr/share/keyrings/trivy.gpg
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $DISTRO_CODENAME main" | \
  sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y trivy

# -----------------------------------------------------------------------------
# Final Cleanups and Status Checks
# -----------------------------------------------------------------------------
# Print software versions for verification
echo "==== Installed Versions ===="
java -version
jenkins --version || echo "Jenkins may not report version yet"
docker --version
aws --version
kubectl version --client
eksctl version
terraform -version
helm version
trivy --version

# Optional reboot to apply group membership (Jenkins → Docker group)
# Reboot will interrupt user data execution, so uncomment only if you restart manually after.
sudo reboot
