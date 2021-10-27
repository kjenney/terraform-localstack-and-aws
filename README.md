# terraform-localstack-and-aws

Running LocalStack against the same Infrastructure that is deployed to AWS

My use case:
* An AWS account provisioned with Terraform
* I don't have access to the AWS account
* I need to make major changes and validate that they work

My solution:
* Use Localstack with TerraTest
* Use Jinja2 to Override the backend

## Requirements

* Bash
* Python and Jinja2
* Terraform
* LocalStack

## Running LocalStack

`localstack start`

## Testing with LocalStack

`./deploy.sh us-east-1 localstack`

Make sure to stop LocalStack after it's deployed and delete the local state.

## Deploying on AWS

I would not recommend to deploy any of this to AWS. Rather you can use this pattern to suit your needs with your existing Terraform code.

***IF YOU RUN THIS IT WILL FAIL***:

 `./deploy.sh us-east-1 aws`
 
 Special thanks to Martin Atkins who gave me the solution for running LocalStack and AWS alongside each other. 
https://stackoverflow.com/questions/69727184/terraform-override-provider-for-use-with-localstack




