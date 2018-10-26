resource "aws_s3_bucket" "website" {
  bucket = "${var.myself}-${var.website_bucket_suffix}"
  acl    = "public-read"

  policy = <<EOF
{
  "Id": "bucket_site",
  "Version": "2012-10-17",
  "Statement": [
		{
			"Sid": "bucket_policy_site_main",
			"Action": [
			"s3:GetObject"
			],
			"Effect": "Allow",
			"Resource": "arn:aws:s3:::${var.myself}-${var.website_bucket_suffix}/*",
			"Principal": "*"
		}
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags {
    Owner   = "${var.myself}"
    Project = "terraform-workshop"
  }

  force_destroy = true
}

resource "aws_s3_bucket_object" "site_index" {
  bucket = "${aws_s3_bucket.website.id}"
  key    = "index.html"
  source = "${path.root}/files/index.html"
	content_type = "text/html"
  etag   = "${md5(file("${path.root}/files/index.html"))}"
}

resource "aws_s3_bucket_object" "site_error" {
  bucket = "${aws_s3_bucket.website.id}"
  key    = "error.html"
  source = "${path.root}/files/error.html"
	content_type = "text/html"
  etag   = "${md5(file("${path.root}/files/error.html"))}"
}
