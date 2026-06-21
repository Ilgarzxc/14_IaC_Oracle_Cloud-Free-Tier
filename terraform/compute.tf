resource "oci_core_instance" "staging_vm" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment_id
    shape = var.shape
    shape_config {
      ocpus = "1"
      memory_in_gbs = "1"
    }
    source_details {
      source_id = var.source_id
      source_type = "image"
    }

    # Optional
    display_name = var.instance_display_name
    create_vnic_details {
      assign_public_ip = true
      subnet_id = var.subnet_id
    }
    metadata = {
      ssh_authorized_keys = file(var.ssh_public_key_path)
    }
    preserve_boot_volume = false 
}