## Project URL
https://roadmap.sh/projects/iac-digitalocean
Actions described below are applicable on Linux OS
Instance created using Oracle Cloud instead of Digital Ocean to avoid extra costs. Oracle have free-tier options without expiration date.

## Prerequisites
1) Confirm that you installed Terraform according to https://developer.hashicorp.com/terraform/tutorials/oci-get-started/install-cli and check the installation with:

```bash
terraform --version
```

2) Get tenancy details from https://cloud.oracle.com/tenancy. You can save this information to environment variables, but don't forget to exclude the `.env` file from your commits via `.gitignore`.
3) Follow https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix to install the Oracle CLI.
4) Create a pair of SSH keys.


## OCI CLI: General Setup
1) Run `oci session authenticate`. From the given list, choose the index or name of your tenant region. Detailed information about regions is available at https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm.
2) You will be prompted to authorize the CLI session in the browser. This completes configuration of the default profile.
3) To configure an additional named profile, run `oci session authenticate` again and authorize the session.
4) Enter the desired profile name when prompted. The output shows where the CLI stored your token. Terraform will automatically detect the token and use it to create infrastructure. More detailed guidelines are available at https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-build#prerequisites

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
This guide can be used as reference. Below are the crucial steps for cloud instance creation.

1) The virtual cloud network (VCN) should be configured initially on the Oracle website using the setup wizard UI.

2) Gather required information, such as:

- Compartment name
- Compartment ID
- Subnet ID
- Source ID
- Shape (compute instance)
- SSH authorized key (public key path)
- Private SSH key path

These values can be stored as variables in a `.env` file, but ensure that it's not committed to the public repo.

3) Adjust resource policies for your user, or skip if you already have admin rights in the tenancy.

4) Create authentication scripts according to https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#create-scripts in the `tf_compute` and `tf-provider` folders of your project.

Important: to write and execute these scripts you need to follow https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#gather-info and create RSA keys and add them to your profile settings.

5) Create files with variables: `variables.tf` and a hidden (not committed to the public repo) `terraform.tfvars`, as well as `availability-domains.tf`, `outputs.tf`, `provider.tf`, `versions.tf`.

6) Then run the following commands in the `/terraform` folder of the project to check if availability domains will be reflected in the console. If yes, you configured everything correctly:

```bash
terraform init
terraform plan
terraform apply
```

7) Declare a compute resource in `compute.tf` and adjust `outputs.tf` accordingly. Check the requirements and ensure that you're using values compatible with Free Tier if you're on it.

8) Repeat the commands if needed:

```bash
terraform init
terraform plan
terraform apply
```

9) Example of a successful apply output:

```text
oci_core_instance.staging_vm: Creating...
oci_core_instance.staging_vm: Still creating... [00m10s elapsed]
oci_core_instance.staging_vm: Still creating... [00m20s elapsed]
oci_core_instance.staging_vm: Still creating... [00m30s elapsed]
oci_core_instance.staging_vm: Creation complete after 35s [id=ocid1....]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
