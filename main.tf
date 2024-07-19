# resource "aws_dynamodb_table" "terraformstatefiles-plat-s3-terraform-locks-027924551270" {
#   name         = "terraformstatefiles-plat-s3-terraform-locks-027924551270"
#   billing_mode = "PAY_PER_REQUEST"
#   ttl {
#     attribute_name = "expiresAt"
#     enabled        = true
#   }
# }

# resource "aws_lambda_function" "ttldynamo" {
#   function_name = "ttldynamo"
#   role          = "arn:aws:iam::027924551270:role/service-role/ttldynamo-role-s2zxyi1t"
#   s3_bucket     = ""
#   s3_key        = ""
#   runtime       = "python3.12"
#   handler       = "lambda_function.lambda_handler"
#   timeout       = 3
# }
# resource "aws_kinesis_stream" "TTLstream" {
#   name = "datalakeTTLprocessor"
#   #   shard_count = 1
#   retention_period = 24
#   stream_mode_details {
#     stream_mode = "ON_DEMAND"
#   }
# }

# resource "aws_dynamodb_kinesis_streaming_destination" "example" {
#   stream_arn = aws_kinesis_stream.TTLstream.arn
#   table_name = aws_dynamodb_table.terraformstatefiles-plat-s3-terraform-locks-027924551270.name
# }

# resource "aws_lambda_event_source_mapping" "dataLakeAnalyticsTTLMapping" {
#   event_source_arn = aws_kinesis_stream.TTLstream.arn
#   function_name    = aws_lambda_function.ttldynamo.function_name
#   starting_position = "LATEST"
# }
# resource "aws_iam_role" "ttldynamo-role-s2zxyi1t" {
#   name = "ttldynamo-role-s2zxyi1t"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"  # Adjust service if needed
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }


# # IAM Role Policies
# resource "aws_iam_policy" "kinesis_to_s3_lambda_policy" {
#   name        = "kinesis-to-s3-lambda-policy"
#   description = "Policy for Lambda to read from Kinesis and write to S3"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "kinesis:GetRecords",
#         "kinesis:GetShardIterator",
#         "kinesis:DescribeStream",
#         "kinesis:ListStreams"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "firehose:PutRecord",
#         "firehose:PutRecordBatch"
#       ],
#       "Resource": "*"
#     },
#     {
#             "Effect": "Allow",
#             "Action": "kinesis:*",
#             "Resource": "*"
#         },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "s3:PutObject",
#         "s3:GetObject",
#         "s3:ListBucket"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# # Attach IAM Policy to IAM Role
# resource "aws_iam_role_policy_attachment" "kinesis_to_s3_lambda_attachment" {
#   policy_arn = aws_iam_policy.kinesis_to_s3_lambda_policy.arn
#   role       = aws_iam_role.ttldynamo-role-s2zxyi1t.name
# }

resource "aws_kinesis_firehose_delivery_stream" "foo" {
  name        = "dataLakeAnalytic-restored-vijay-Firehos"
  destination = "extended_s3"
  version_id  = "27"
  extended_s3_configuration {
    role_arn            = "arn:aws:iam::217753549699:role/service-role/KinesisFirehoseServiceRole-dataLakeAnaly-eu-west-2-1689760289788"
    error_output_prefix = "error/"
    bucket_arn          = "arn:aws:s3:::datalakeanalytic-restored-vijay"
    prefix              = "data/"
    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesisfirehose/dataLakeAnalytic-restored-vijay-Firehos"
      log_stream_name = "DestinationDelivery"
    }
    compression_format = "UNCOMPRESSED"
    # role_arn = "arn:aws:iam::217753549699:role/service-role/KinesisFirehoseServiceRole-dataLakeAnaly-eu-west-2-1689760289788"
    s3_backup_mode = "Disabled"

  }

  # kinesis_source_configuration { # forces replacement
  #   kinesis_stream_arn = aws_kinesis_stream.TTLstream.arn
  #   role_arn           = arn:aws:iam::217753549699:role/service-role/KinesisFirehoseServiceRole-dataLakeAnaly-eu-west-2-1689760289788
  # }

  # server_side_encryption {
  #     enabled  = false
  #     key_type = "AWS_OWNED_CMK"
  #   }

}

almighty push pheww 
padaow