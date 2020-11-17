# temp secret manager and  aws provider
provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/home/ec2-user/.aws/NicksS3/cred"
    profile = "customprofile"
}
# configure s3 bucket for tf state (Do Just the provider S3 and Dynamo DB first before backend)
resource "aws_s3_bucket" "nick9307s3bucket" {
    bucket = "nick9307s3bucket"
        
    lifecycle {
        prevent_destroy = true
    }
    
    versioning {
        enabled = true
    }
    
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
   
    tags =  {
        Name = "nick"
        Owner = "nick"
        Application = "TF-Backend"
        Compliance = "Prod"
        Member_TF = true
    }

}
#### backend
terraform {
        backend "s3" {
        shared_credentials_file = "/home/ec2-user/.aws/NicksS3/cred"
        profile = "customprofile"
        bucket = "nick9307s3bucket"
        key = "home/ec2-user/environmnet/S3lab/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "tf-dev-state-lock"
        encrypt = true
        }
}
