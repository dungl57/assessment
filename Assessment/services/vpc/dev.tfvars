environment = "dev"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]
default_tags = {
  Owner       = "DevOps"
  Environment = "dev"
}
