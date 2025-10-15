# OIDC Provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github" {
  url = var.git_oidc_url

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.git_oidc_thumbprint_list
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-iam-role-deploy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.github_org}/${var.github_hugo_repo}:*",
              "repo:${var.github_org}/${var.github_startpage_repo}:*"
            ]
          }
        }
      }
    ]
  })
  tags = {
    Name = "GitHub Actions Deploy Role"
  }
}

# IAM Policy for GitHub Actions
resource "aws_iam_role_policy" "github_actions" {
  name = "github-actions-iam-role-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.hugo_bucket_arn,
          "${var.hugo_bucket_arn}/*",
          var.startpage_bucket_arn,
          "${var.startpage_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation",
          "cloudfront:ListInvalidations"
        ]
        Resource = [
          var.hugo_cloudfront_dist_arn,
          var.startpage_cloudfront_dist_arn
        ]
      }
    ]
  })
}
