# Terraform + AWS — OIDC-enabled CI/CD for Static Website

> This repository provisions AWS infrastructure to enable a secretless CI/CD pipeline between GitHub Actions and AWS using OpenID Connect (OIDC). The stack creates an IAM role that GitHub Actions can assume, an S3 bucket to host static site assets, and a CloudFront distribution to serve the site globally.

## Project Overview

This Terraform project automates the AWS infrastructure required to host a static website and allow GitHub Actions to deploy to AWS **without long-lived credentials** by using GitHub's OIDC provider and an IAM role. The infrastructure includes:

* An **IAM OIDC provider** (GitHub) and an **IAM role** configured with a minimal trust policy that allows GitHub Actions to assume the role.
* An **S3 bucket** to store static website files.
* A **CloudFront distribution** fronting the S3 bucket for low-latency, global delivery.

**Primary goal:** Enable secure, auditable, and credential-free deployments from GitHub Actions into the AWS account.

## Key Terms (brief)

* **OIDC (OpenID Connect)**: An identity layer on top of OAuth 2.0. GitHub exposes an OIDC provider so workflows can request tokens to authenticate to AWS.
* **IAM Role**: An AWS identity with permissions (policy) that GitHub Actions assumes using OIDC.
* **S3 Bucket**: Object storage used for hosting static website files.
* **CloudFront**: AWS CDN used to distribute the static site globally for performance and caching.

## Prerequisites

Before you begin, ensure you have the following:

* An AWS account with permissions to create IAM, S3, CloudFront, and other resources (recommended: an IAM user or role with Administrator privileges for initial deployment).
* [Terraform](https://www.terraform.io/) (v1.4+ recommended) installed locally.
* [AWS CLI](https://aws.amazon.com/cli/) (for manual checks & invalidations) installed and configured if you plan to run commands locally.
* A GitHub account and repository where the website source and Actions workflow will live.
* (Recommended) A Terraform remote state backend (e.g., S3 + DynamoDB for locking) for team usage.

> **Note:** After provisioning, GitHub Actions will be able to obtain temporary credentials using OIDC — no AWS access keys are required in GitHub secrets.

---

## Setup — Step-by-step

### 1. Clone the repository

```bash
git clone https://github.com/erikngigi/terraform-aws-ci-cd.git
cd terraform-aws-ci-cd
```

### 2. Configure Terraform variables

Create or update a `*.tfvars` file with values for required variables such as region and site name.

```hcl
aws_region = "us-east-1"
project_name = "my-static-site"
# any other variables your module requires
```

> **Tip:** Use a remote state backend for collaboration. Common pattern: S3 backend + DynamoDB table for state locking.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan & Apply

```bash
terraform plan -out="infra.tfplan"
terraform apply "infra.tfplan"
```

Terraform will create the IAM OIDC provider, an IAM role with a trust policy scoped to your GitHub repo (or organization), an S3 bucket, and a CloudFront distribution.

### 5. Retrieve outputs

After `apply` completes, list the outputs to get values you'll use in GitHub Actions:

```bash
terraform output
```

Key outputs (provided by this project):

* `github_actions_role_arn` — ARN of the IAM role GitHub Actions will assume.
* `s3_bucket_name` — S3 bucket name for website content.
* `cloudfront_distribution_id` — CloudFront distribution ID.

## CI/CD Workflow Explanation (how deployments work)

**High level**

1. A change is pushed (or a PR is merged) on your GitHub repository.
2. GitHub Actions runs a workflow that asks GitHub's OIDC service for a token scoped to the repository (and optionally to a specific workflow/job).
3. The workflow uses the token to call `sts:AssumeRoleWithWebIdentity` against AWS and obtains temporary credentials.
4. With those temporary credentials, the workflow uploads the built static assets to the S3 bucket and optionally invalidates CloudFront to publish the change.

**Why OIDC?**

* OIDC removes the need to store long-lived AWS access keys inside GitHub Secrets.
* The IAM role can be scoped to only allow the particular GitHub repository (and optionally branch/workflow), implementing the principle of least privilege.

---

## Example GitHub Actions Workflow

Below is a sample `.github/workflows/deploy.yml` that demonstrates a common flow: check out code, build (if needed), sync to S3, and invalidate CloudFront.

```yaml
name: Deploy Static Site

on:
  push:
    branches:
      - main

permissions:
  id-token: write          # required to request an OIDC token
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install dependencies (example)
        run: |
          # run your build steps here if needed
          # e.g. npm ci && npm run build
          echo "build step placeholder"

      - name: Configure AWS credentials via OIDC
        uses: aws-actions/configure-aws-credentials@v2
        with:
          role-to-assume: ${{ vars.GITHUB_AWS_ROLE_ARN }} # or use repository secret
          aws-region: us-east-1

      - name: Sync site to S3
        run: |
          aws s3 sync ./public s3://${{ vars.S3_BUCKET_NAME }} --delete

      - name: Create CloudFront invalidation
        run: |
          aws cloudfront create-invalidation --distribution-id ${{ vars.CLOUDFRONT_DISTRIBUTION_ID }} --paths "/*"
```

**Notes:**

* The `permissions: id-token: write` line is mandatory so the runner can request an OIDC token.
* `aws-actions/configure-aws-credentials@v2` handles the OIDC token exchange and sets temporary environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`) for following steps.
* You can reference the Terraform outputs by setting them as GitHub Environments/Repository Variables (see next section).

## Terraform Outputs — Detailed Explanation

This project produces three primary outputs. Each is intended for direct use in the GitHub workflow.

1. **`github_actions_role_arn`**

   * **What it is:** The full ARN of the IAM role configured for GitHub Actions to assume using OIDC.
   * **Why it's needed:** GitHub Actions needs the role ARN so the `aws-actions/configure-aws-credentials` action (or custom STS call) knows which role to assume.
   * **How to use it:** Add the ARN to your repository variables (or reference it via an automated sync script). Example use in workflow: `role-to-assume: ${{ vars.GITHUB_AWS_ROLE_ARN }}`.

2. **`s3_bucket_name`**

   * **What it is:** The name of the S3 bucket that stores the static website assets.
   * **Why it's needed:** The deployment step (`aws s3 sync`) needs this value to upload files.
   * **How to use it:** Pass it as an env var or GitHub variable: `S3_BUCKET_NAME`.

3. **`cloudfront_distribution_id`**

   * **What it is:** The CloudFront distribution ID created to serve the website.
   * **Why it's needed:** After content upload, the distribution should be invalidated so the new content is served. Use this ID in `aws cloudfront create-invalidation`.
   * **How to use it:** Add as `CLOUDFRONT_DISTRIBUTION_ID` and use it in the invalidation CLI call.

---

## Security & Best Practices

Follow these recommendations when using this project in production:

* **Least privilege:** Attach policies to the IAM role that only include permissions required for the actions the workflow performs (e.g., `s3:PutObject`, `s3:DeleteObject`, `cloudfront:CreateInvalidation`). Avoid broad `*` permissions.

* **Scope trust policy:** In the IAM role trust policy, scope the `Condition` to a specific `sub` claim matching your repo or organization (e.g., `repo:your-org/your-repo:ref:refs/heads/main`) so only specific workflows/branches can assume the role.

* **Use Terraform version and provider pinning:** Pin Terraform and AWS provider versions in `required_providers`/`required_version` to ensure stable behavior across runs.

* **Remote state & locking:** Store Terraform state in a remote backend (S3 + DynamoDB locking) to avoid state corruption and allow team collaboration.

* **Protect repo settings:** Only administrators should be able to edit repository/environment variables or secrets that could change your infrastructure configuration.

* **Monitor & Audit:** Enable CloudTrail, and monitor `sts:AssumeRoleWithWebIdentity` calls for unusual activity.

* **Use short-lived tokens:** By design, OIDC flows grant short-lived credentials — log and alert on suspicious patterns.

* **Review CloudFront caching behavior:** Ensure your invalidation policy or cache-control headers are correct to avoid stale content.

---

## Cleanup

If you want to remove everything created by this Terraform project:

1. Remove any GitHub repository variables created from the outputs (optional but tidy).
2. Run:

```bash
terraform destroy
```

3. Verify in the AWS Console that S3 buckets, CloudFront distributions, and IAM roles/providers are removed.

> **Important:** Destroying resources like S3 buckets that contain objects may require manual emptying or adding `force_destroy = true` in the S3 bucket resource. Use caution: destroying may permanently remove data.

---

## Example IAM Policy (minimal example)

Below is an example inline policy you might attach to the role to support typical static-site deployment tasks. **Adjust to your exact needs** and replace resources with the actual ARNs from your environment.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:PutObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::my-static-site-bucket/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudfront:CreateInvalidation"
      ],
      "Resource": [
        "arn:aws:cloudfront::123456789012:distribution/EDFDVBD6EXAMPLE"
      ]
    }
  ]
}
```

---

## Troubleshooting

* **`AccessDenied` when calling STS:** Check the trust policy on the IAM role — ensure the OIDC provider and `sub` conditions allow your repo/workflow.
* **OIDC token not available in workflow:** Ensure `permissions: id-token: write` is set and you're using a recent runner.
* **CloudFront returns old content:** Confirm your invalidation succeeded (check CloudFront console) and verify cache-control headers.
* **S3 bucket upload failing:** Check bucket policy / block public access settings and that the role has `s3:PutObject` permissions on the bucket.

---

## Next Steps & Enhancements

* Add automatic repository variable sync after `terraform apply` (using `gh` CLI) to reduce manual steps.
* Implement multi-environment deployments (staging/prod) with separate roles and buckets.
* Add a pipeline that automatically runs `terraform plan` on pull requests for infra changes.

---

## Contact / Contributing

If you find issues or want to extend the modules, please open an issue or a PR. Follow the repository's contribution guidelines for proposing changes.
