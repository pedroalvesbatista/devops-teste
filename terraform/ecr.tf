# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create an AWS ECR Repository
resource "aws_ecr_repository" "main-repo" {
  name                 = "main-repo"  # Name of the repository
  image_tag_mutability = "MUTABLE"  # You can overwrite image tags in this repo

  image_scanning_configuration {
    scan_on_push = true  # Images pushed to the repo will be scanned for vulnerabilities
  }
}

# Define an ECR repository policy to control access to the repository
resource "aws_ecr_repository_policy" "main-repo" {
  repository = aws_ecr_repository.main-repo.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPull",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ]
    }
  ]
}
EOF
}