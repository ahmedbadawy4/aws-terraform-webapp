# Terraform Provisioning of basic and simple webapp
 Terraform code to provision fully operated environment consists of EC2 act as an application and PostgreSQL database 
 All components are in the same vpc with no public access for the database except from and to Ec2 private subnet and Ec2 is only public accessible on 80 and 22 from target subnet.  

- The code made consists of a modules to easily reuse it 

- the secrets and password can be managed by kms and parameter store.

- EC2 has only Read only access to this parameters and kms encryption and decryption 


## Prerequisites:

- install [terraform](https://terraform.io/downloads.html).

- install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

- [Set up your AWS account](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180#a9b0).

- create keypair for example `[ec2_key.pem]` to make Ec2 accessable. 
 `notes: it should be in the same region where we will create our environment`

- s3 bucket as a terraform backend.

## Usage:
- Update the desire values in the terraform.tfvars
 
- Run `terraform init`

- Run `terraform plan`
    check the what will changes/new resources that planned. 
- Run `terraform apply`

- Get the master database password 

```
# Assume region is us West (N. California), we need to list all parameters 

aws ssm describe-parameters --region "us-west-1"

aws ssm get-parameter --name "<parameter_name>" --region "us-west-1" --with-decryption

# the "Value": "<database_password>"
```

- connect to the database

```
psql --host=<databasehost> --port=5432 --username=<database_user> --password --dbname=<database_name>

```

## TO Do List:
- Enhance AWS tags by mix default tags and extra tags.
- Enhance networkng.
- Enhance the Database configurations and enable backup.
- refactor the code to Terraform CDK typescript or python.
- Create CI/CD pipeline
- Add Ansible script to install nessesary packages on the ec2 instance.
