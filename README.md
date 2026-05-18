## Project URL
https://roadmap.sh/projects/iac-digitalocean
Actions described below applicable on Linux

## Prerequisites
1) Confirm that you installed Terraform according to the https://developer.hashicorp.com/terraform/tutorials/oci-get-started/install-cli and check the installation with `terraform --version`
2) Get tenancy details from https://cloud.oracle.com/tenancy. You can save this information to environmental variables, but don't forget to exclude .env file from your future commits using .gitignore.
3) Follow https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix to install Oracle CLI

## OCI CLI: General Setup
1) Run command `oci session authenticate`. From the given list you need to choose an index or name of your tenant region and enter it. Detailed information about the regions can be found there https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm 
2) You will be prompted to authorize CLI session in browser. With this action you will finish the configuration of default profile.
3) To configure additional named profile you need to run `oci session authenticate` again and authorize your session. 
4) Enter desired profile name when prompted. The output prints the location where the CLI has stored your token. Terraform will automatically detect the token later in the tutorial, and use the credentials there to create infrastructure. The token has a 1-hour Time To Live (TTL). If it expires, refresh it by providing the profile name. More detailed guideline available https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-build#prerequisites

## Write configuration


