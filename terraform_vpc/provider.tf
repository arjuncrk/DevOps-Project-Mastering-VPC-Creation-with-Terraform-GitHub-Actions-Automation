terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-statefile-bucket-project-1"
    key            = "dev/terraform.tfstate"  #some_environment/terraform.tfstate
    region         = "us-east-1"
    # encrypt        = true
    # kms_key_id     = "THE_ID_OF_THE_KMS_KEY"
    # dynamodb_table = "THE_ID_OF_THE_DYNAMODB_TABLE"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}