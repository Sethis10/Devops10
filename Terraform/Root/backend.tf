terraform {
  backend "s3" {
    bucket = "sagar-s3-attempt1"
    key = "backend/medtronic/mdm.tfstate"
    region = "us-east-1"
  }
}