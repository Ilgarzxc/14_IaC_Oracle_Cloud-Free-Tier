## Project URL
https://roadmap.sh/projects/iac-digitalocean
Actions described below applicable on Linux

## Prerequisites
1) Confirm that you installed Terraform according to the https://developer.hashicorp.com/terraform/tutorials/oci-get-started/install-cli and check the installation with `terraform --version`
2) Get tenancy details from https://cloud.oracle.com/tenancy. You can save this information to environmental variables, but don't forget to exclude .env file from your future commits using .gitignore.
3) Follow https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix to install Oracle CLI
4) Created pair of ssh keys


## OCI CLI: General Setup
1) Run command `oci session authenticate`. From the given list you need to choose an index or name of your tenant region and enter it. Detailed information about the regions can be found there https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm 
2) You will be prompted to authorize CLI session in browser. With this action you will finish the configuration of default profile.
3) To configure additional named profile you need to run `oci session authenticate` again and authorize your session. 
4) Enter desired profile name when prompted. The output prints the location where the CLI has stored your token. Terraform will automatically detect the token later in the tutorial, and use the credentials there to create infrastructure. More detailed guideline available https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-build#prerequisites

## OCI CLI: Session Authentication Notes

OCI CLI supports browser‑based authentication. This method creates a temporary security token stored in:

```
~/.oci/sessions/<profile_name>/token
```

**Key points to remember:**

- The token has a 1‑hour TTL.
- When it expires, OCI CLI will prompt you to re‑authenticate.
- Any command using this profile must include: `--auth security_token`
- Terraform automatically detects the token and uses it without additional flags.

**Steps to authenticate:**

1. Run:
   ```bash
   oci session authenticate
   ```

2. Select your region.

3. Complete the login in the browser window.

4. When prompted, enter the profile name.

5. After successful authentication, test the profile:
   ```bash
   oci iam region list --profile <name> --auth security_token
   ```

If the token expires, simply re-run:

```bash
oci session authenticate --profile <name>
```

## Write configuration
https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-compute.htm 
This guide can be used as a reference, but below I will pinpoint some crucial steps of the cloud instance creation.

1) Virtual cloud network should be configured initially on the Oracle website with the setup wizard UI
2) Gather required information, such as: 
- Compartment name
- Compartment ID
- Subnet ID
- Source ID
- Shape (compute instance)
- SSH Authorized Key (public key path)
- Private SSH Key Path
These values can be stored as the variables in your .env file, but ensure that its not commited to the public repo.
3) Adjust resource policies for your user or skip if the you already have admin rights in the tenancy.
4) Create authentication scripts according to the https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#create-scripts guideline in tf_compute and tf-provider folders of your project
Important: to write and execute these scripts you need to follow https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#gather-info and create RSA keys + add into your profile settings 
5) Create files with variables: variables.tf and hidden (not commited to public repo) terraform.tfvars as well as availability-domains.tf, outputs.tf, provider.tf, versions.tf
6) Then run 
terraform init
terraform plan
terraform apply
commands in the /terraform folder of the project to check if available domains will be reflected in the console. If yes - you configured everything right.

7) Declare a compute resource in compute.tf file and adjust outputs.tf accordingly. Check the requirements and ensure that you're using values compatible with Free Tier if you're on it