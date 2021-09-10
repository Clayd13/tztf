module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "web-apache"

  ami                    = var.ami_image
  instance_type          = var.instance_type_size
  key_name               = module.key_pair.key_pair_key_name
  monitoring             = false
  vpc_security_group_ids = [module.security-group_http-80.security_group_id, module.ssh_security_group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  user_data = <<-EOF
  #!/bin/bash
  sudo yum install -y jq* 
  echo "*** Installing httpd"
 #sudo yum update -y
  sudo yum install httpd -y
  instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
  data_creaion=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep pendingTime | awk -F\" '{print $4}')
  aws ec2 create-tags --resources "$instanceId" --tags Key=Data_creation,Value="$data_creaion" --region "$region"
  echo "<h1>$instanceId</h1>" > /var/www/html/index.html
  sudo service httpd start
  sudo service httpd enable
  echo "*** Completed Installing apache2"
  EOF


  tags = {
    Your_First_Name = var.your_first_name
    Your_Last_Name  = var.your_last_name
    AWS_Account_ID  = data.aws_caller_identity.current.account_id
    Terraform       = "true"
    Environment     = "tz"
  }
}
