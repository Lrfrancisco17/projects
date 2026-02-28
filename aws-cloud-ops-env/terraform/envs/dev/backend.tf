terraform {
  backend "s3" {
    bucket         = "aws-cloud-ops-lab-tfstate-dev" # replace with your bucket name
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-cloud-ops-lab-tf-locks"
    encrypt        = true
  }
}

