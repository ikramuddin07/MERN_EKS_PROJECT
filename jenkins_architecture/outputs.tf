output "ec2_instance_id" {
  value = module.jenkins_instance.instance_id
}
output "ec2_public_ip" {
  value = module.jenkins_instance.public_ip
}
output "ec2_subnet_id" {
  value = module.jenkins_instance.subnet_id
}