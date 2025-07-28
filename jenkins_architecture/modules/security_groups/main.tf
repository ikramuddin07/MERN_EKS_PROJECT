##########################
# Security Groups
##########################

##########################
# Jenkins Security Group
##########################

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins EC2 instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "jenkins-sg"
  }
}

# Inbound Rules
resource "aws_vpc_security_group_ingress_rule" "jenkins_http" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "49.37.179.251/32"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_https" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "49.37.179.251/32"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_jenkins" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "49.37.179.251/32"
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "tcp"
  description       = "Allow Jenkins UI"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_sonarqube" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "49.37.179.251/32"
  from_port         = 9000
  to_port           = 9000
  ip_protocol       = "tcp"
  description       = "Allow SonarQube UI"
}

# Outbound (Allow All)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # all protocols
  description       = "Allow all outbound traffic"
}


##########################
# Basic Security Group
##########################

################################
# SSH Included Security Group
################################