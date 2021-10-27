resource "aws_s3_bucket" "test-bucket" {
  acl    = "private"

  tags = {
    Environment = "terraform.workspace"
    ManagedBy   = "Terraform"
  }
}