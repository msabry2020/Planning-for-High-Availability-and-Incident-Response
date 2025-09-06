terraform {
   backend "s3" {
     bucket = "udacity-tf-mamin-zone2" # Replace it with your S3 bucket name
     key    = "terraform/terraform.tfstate"
     region = "us-west-1"
   }
 }

 provider "aws" {
   region = "us-west-1"
 }
