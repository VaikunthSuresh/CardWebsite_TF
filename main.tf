terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }
  backend "s3" {
    bucket = "terraform-bucket-27052001"
    key = "terraform_state_file"
    region = "ap-south-1"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}


module "vpc_module" {
  source = "./module_vpc"
  vpc_cidr_block = "10.10.0.0/16"
}
module "sg_module" {
  source = "./module_security_group"
  vpc_id = module.vpc_module.vpc_id
}

module "subnet_module" {
  source = "./module_subnets"
  private_cidr_blocks = [ "10.10.1.0/24", "10.10.2.0/24" ]
  public_cidr_blocks = [ "10.10.3.0/24", "10.10.4.0/24" ]
  availability_zones = [ "ap-south-1a", "ap-south-1b" ]
  vpc_id = module.vpc_module.vpc_id
}

module "network_module" {
    source = "./module_network"  
    vpc_id = module.vpc_module.vpc_id
    private_subnets = module.subnet_module.subnets_id_private
    public_subnets = module.subnet_module.subnets_id_public
}

module "lt_module" {
  source = "./module_launch_template"
  ami_id = "ami-007020fd9c84e18c7"
  instance_type = "t2.micro"
  user_file = "./module_launch_template/user_data.sh"
  security_group_id = module.sg_module.sg_id
}

module "tg_module" {
  source = "./module_target_group"
  vpc_id = module.vpc_module.vpc_id
}

module "asg_module" {
  source = "./module_asg"
  launch_template_id = module.lt_module.lt_id
  subnet_ids = module.subnet_module.subnets_id_public
  tg_arns = module.tg_module.tg_arn
}

module "alb_module" {
    source = "./module_alb"
    sg_id = module.sg_module.sg_id
    tg_arns = module.tg_module.tg_arn
    subnet_ids = module.subnet_module.subnets_id_public
}