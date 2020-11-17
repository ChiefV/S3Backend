resource "aws_dynamodb_table" "terraform_locks" {
name = "tf-dev-state-lock" 
billing_mode = "PAY_PER_REQUEST"
hash_key = "LockID"

attribute {
    name = "LockID"
    type = "S"
}

tags = {
    Name = "nick"
    Owner = "nick"
    Application = "TF-Backend"
    Compliance = "Prod"
    Member_TF = true
    }
}

