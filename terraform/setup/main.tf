
#
# terraform s3 backend config
#

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-remote-state-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name           = "terraform-remote-state-lock-${data.aws_caller_identity.current.account_id}"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_user" "terraform" {
  name = "my-terraform-user"
}

resource "aws_iam_access_key" "terraform" {
  user = aws_iam_user.terraform.name
}

resource "aws_iam_user_policy" "terraform" {
  name = "my-terraform-policy"
  user = aws_iam_user.terraform.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}"]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": ["arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}/*"]
    },
    {
      "Effect": "Allow",
      "Action": ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"],
      "Resource": ["${aws_dynamodb_table.dynamodb_terraform_state_lock.arn}"]
    }
  ]
}
EOF

}

resource "aws_iam_role" "terraform_role" {
  name               = "my-terraform-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "AWS": "${aws_iam_user.terraform.arn}"
        },
        "Effect": "Allow",
        "Sid": ""
        }
    ]  
}
EOF
}

