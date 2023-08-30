provider "aws" {
  region = var.region # Replace with your desired region
}

terraform {
  required_version = ">= 0.13"

  backend "s3" {
    bucket         = "nclouds-academy-vijay"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform_train_locks"
  }
}