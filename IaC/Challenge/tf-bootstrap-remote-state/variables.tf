variable "aws_region" {
    description = "The AWS region where the resources are created"
    type        = string
    default     = "us-east-2"
}

variable "s3_bucket_name" {
    description = "Name of the S3 bucket to store the remote state"
    type        = string
    default     = "tf-challenge-s3b-dereck" 
}

variable "dynamodb_table_name" {
    description = "Name of the DynamoDB table to handle state locks"
    type        = string
    default     = "terraform-locks"
}
