provider "oci" {
    tenancy_ocid = var.tenancy_id
    user_ocid = var.user_ocid
    private_key_path = var.private_key_path
    fingerprint = var.fingerprint
    region = var.region
}