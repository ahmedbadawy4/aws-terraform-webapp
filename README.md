# Web server and PostgreSQL on AWS with Terraform

A Terraform reference setup for one EC2 web server and one PostgreSQL database on Amazon RDS, in a new VPC. RDS creates the database password and keeps it in AWS Secrets Manager. A KMS key encrypts the password and the database storage. The server's IAM role can read that one secret and nothing else.

It is a small reference setup, not a production platform. [Design limits](#design-limits) lists what it leaves out.

## What it creates

- A VPC (`10.0.0.0/16`) with an internet gateway and two public subnets in two availability zones.
- An EC2 instance on Amazon Linux 2023 with a public IP, an encrypted gp3 root volume and IMDSv2 required. At first boot it installs the PostgreSQL 17 client (`psql`).
- A security group for the instance that allows ports 22 and 80 only from the CIDR blocks you list in `allowed_cidr_blocks`. With the default empty list nothing outside the VPC can connect.
- An RDS PostgreSQL 17 instance that is not publicly accessible. Its security group allows port 5432 only from the instance's security group.
- A KMS key (rotation on) that encrypts the database storage and the master password secret.
- The master password, created by RDS in Secrets Manager. It is not in the Terraform code, the variables or the outputs.
- An IAM role and instance profile for the EC2 instance. The role can read the database secret and decrypt with the KMS key.
- An SSH key pair. Terraform generates the key, registers the public half in AWS and writes the private half to `<environment>-<application>.pem` in the repository folder (git ignores `*.pem`).

## Layout

| Path | What it holds |
|------|---------------|
| `versions.tf`, `providers.tf` | Terraform and provider versions, the S3 backend, default tags |
| `variables.tf`, `main.tf`, `outputs.tf` | The root module that wires the modules together |
| `modules/vpc` | VPC, subnets, route, DB subnet group, security groups |
| `modules/rds` | The PostgreSQL instance |
| `modules/iam-secrets` | KMS key, IAM role and instance profile |
| `modules/ec2-key` | SSH key pair and the private key file |
| `modules/ec2` | The EC2 instance |
| `terraform.tfvars.example` | Example values |
| `.tflint.hcl`, `.pre-commit-config.yaml`, `.github/workflows/ci.yaml` | Linting, hooks and CI |

Each module has its own README with its inputs and outputs.

## Prerequisites

- Terraform 1.10 or newer. The S3 backend uses native state locking (`use_lockfile`), which needs 1.10.
- AWS credentials in your shell, for example from `aws configure sso`, with permission to create the resources above. `aws sts get-caller-identity` shows which account you are using.
- An S3 bucket for the state, with versioning on. New buckets are encrypted and block public access by default.

```bash
aws s3api create-bucket --bucket <state-bucket> --region us-east-1
aws s3api put-bucket-versioning --bucket <state-bucket> --versioning-configuration Status=Enabled
```

For a region other than `us-east-1`, add `--create-bucket-configuration LocationConstraint=<region>` to the first command.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars: set allowed_cidr_blocks to your own public IP address followed by /32

terraform init \
  -backend-config="bucket=<state-bucket>" \
  -backend-config="key=webapp/dev/terraform.tfstate" \
  -backend-config="region=us-east-1"

terraform plan
terraform apply
```

- The backend values are passed on the command line so that no bucket name is stored in the repository. Use a different `key` for each environment.
- After the first `terraform init`, commit `.terraform.lock.hcl`. It pins the provider versions for everyone who uses the repository.
- To remove everything, run `terraform destroy`. The KMS key is scheduled for deletion with a 7 day waiting period. With the default `skip_final_snapshot = true` no database snapshot is kept.

## Connect to the server and the database

Connect to the instance with SSH. The instance needs about a minute after it starts before `psql` is installed. `cloud-init status --wait` blocks until it is done.

```bash
ssh -i "$(terraform output -raw ssh_private_key_path)" ec2-user@"$(terraform output -raw ec2_public_ip)"
```

On the instance, read the password from Secrets Manager and open a `psql` session. The instance role allows exactly this. Replace the four placeholders with the values from `terraform output`.

```bash
export PGPASSWORD="$(aws secretsmanager get-secret-value \
  --region us-east-1 \
  --secret-id <db_master_user_secret_arn> \
  --query SecretString --output text \
  | python3 -c 'import json,sys; print(json.load(sys.stdin)["password"])')"

psql "host=<db_host> port=5432 dbname=<db_name> user=<db_username> sslmode=require"
```

## Variables

| Name | Default | Description |
|------|---------|-------------|
| `application` | none, required | Application name. Lowercase letters, digits and single hyphens, up to 21 characters. It is part of every resource name. |
| `environment` | none, required | Environment name such as `dev` or `prod`. Same rules as `application`. |
| `allowed_cidr_blocks` | `[]` | CIDR blocks that may reach the instance on ports 22 and 80. |
| `aws_region` | `us-east-1` | Region for all resources. |
| `key_pair_name` | `<environment>-<application>` | Name of the generated EC2 key pair and of the `.pem` file. |
| `instance_type` | `t3.micro` | EC2 instance type. It must be x86_64. |
| `db_instance_class` | `db.t3.micro` | RDS instance class. |

The module variables for storage size, backups, Multi-AZ, deletion protection and the final snapshot have defaults in `modules/rds`. Pass them from the root module when you need to change them.

## Checks

| Where | What runs |
|-------|-----------|
| `.github/workflows/ci.yaml`, `terraform` job | `terraform fmt -check`, `terraform init -backend=false`, `terraform validate`, `tflint` with the Terraform and AWS rule sets, and an advisory Checkov scan |
| `.github/workflows/ci.yaml`, `pre-commit` job | `terraform_fmt` and the file hooks: merge conflict markers, trailing whitespace, file endings, YAML syntax, private keys, AWS credentials |
| `.pre-commit-config.yaml` | The same checks plus `terraform_docs`, which regenerates the tables in the module READMEs |

CI has no AWS credentials. It only checks the code and never deploys.

To run the hooks on your computer:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

## Design limits

- Both subnets are public. The database has no public address and accepts connections only from the instance's security group, but there is no private subnet, NAT gateway or VPC endpoint layer.
- There is one instance in one availability zone, with no load balancer, no HTTPS and no auto scaling. Port 80 is open to your CIDR blocks, but no web server is installed. The instance only has the `psql` client.
- The SSH private key is generated by Terraform, so it is also stored in the Terraform state. Keep the state bucket private and encrypted. For anything longer-lived, create the key pair yourself.
- `allowed_cidr_blocks` accepts any CIDR block, including `0.0.0.0/0`. Use your own `/32` address.
- The database defaults suit a short-lived setup: a single burstable instance, `deletion_protection = false` and `skip_final_snapshot = true`. Change them before you store data you need to keep.
- A newer Amazon Linux image does not replace a running instance. To move to a new image, run `terraform apply -replace=module.ec2.aws_instance.this`.
- There are no VPC flow logs, no alarms and no account-level controls such as CloudTrail or AWS Config in this repository.

## License

Apache License 2.0, see [LICENSE](LICENSE).
