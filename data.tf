data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

data "archive_file" "function_code" {

  type        = "zip"
  source_dir  = "${path.module}/function_code/"
  output_path = "${path.module}/function_code/${var.lambda_function_name}.zip"
}



