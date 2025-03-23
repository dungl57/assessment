terraform {
  backend "s3" {
    bucket         = "terraform-test-dav-1"  
    key            = "vpc/state/terraform.tfstate" 
    region         = "ap-southeast-1"           
  }
}
