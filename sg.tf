module "security-group_http-80" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "4.3.0"

  name   = "in-allow-tcp80"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
}


module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name   = "in-allow-tcp22"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
}

