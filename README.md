# document-automation-terraform-modules

Terraform code defining the GCP infrastructure for the [document automation project](https://github.com/fuzzylabs/document-automation).

This code is environment (dev,stage,prod) and region (europe-west1, europe-west2) agnostic. It is intended to be called from a higher level repo that provides appropriate environment and region specific values.

We're using [terragrunt](https://github.com/gruntwork-io/terragrunt) for our Terraform workflow.

## Usage

Example usage of the `service_accounts` module.

Create a `terragrunt.hcl` file.
```
# Use Terragrunt to download the module code
terraform {
   source = "git::git@github.com:fuzzylabs/document-automation-terraform-modules.git//service_accounts?ref=master"
}

# Provide variables for the module
inputs = {
  location = "europe-west1"
  project  = "document-automation-dev"
}
```

Then run Terragrunt.
```
terragrunt apply
```

Robert is your father's brother.
