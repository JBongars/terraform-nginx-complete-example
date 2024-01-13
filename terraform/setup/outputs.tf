output "bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_name" {
  value = aws_dynamodb_table.dynamodb_terraform_state_lock.name
}

output "dynamodb_arn" {
  value = aws_dynamodb_table.dynamodb_terraform_state_lock.arn
}

output "aws_region" {
  value = local.region
}
