terraform {
  backend "s3" {
    bucket         = "ivan-backend-terraform-workshop"
    key            = "terraform.tfstate"
    dynamodb_table = "ivan-backend-terraform-workshop"
  }
}
