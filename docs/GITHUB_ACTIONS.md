## CI/CD Automation with GitHub Actions

This project includes a GitHub Actions-based CI/CD pipeline to automate the deployment of NGINX using Terraform.

### CI Pipeline (`.github/workflows/ci.yaml`)

- **Triggers:** Runs on push events to the `main` branch.
- **Steps:**
  - Builds and pushes a custom NGINX Docker image to Docker Hub.
  - Triggers the CD pipeline.

### CD Pipeline (`.github/workflows/cd.yaml`)

- **Triggers:** Runs manually or via the CI pipeline.
- **Steps:**
  - Configures AWS credentials.
  - Initializes and applies Terraform to deploy infrastructure.
  - Retrieves the ELB URL from Terraform output.
  - Sends a Slack notification with deployment details.

### Secrets Required

To run the workflows, the following GitHub secrets must be configured:

| Secret Name            | Purpose |
|------------------------|---------|
| `DOCKER_USERNAME`      | Docker Hub login username |
| `DOCKER_PASSWORD`      | Docker Hub login password |
| `GH_TOKEN`            | GitHub token for triggering workflows |
| `AWS_ACCESS_KEY_ID`    | AWS credentials for Terraform |
| `AWS_SECRET_ACCESS_KEY` | AWS credentials for Terraform |
| `BUCKET_TF_STATE`      | S3 bucket for Terraform state |
| `SLACK_WEBHOOK_URL`    | Webhook URL for Slack notifications |

