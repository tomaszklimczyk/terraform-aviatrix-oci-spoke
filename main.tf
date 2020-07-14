# Aviatrix OCI Spoke VPC
resource "aviatrix_vpc" "oci_spoke_vcn" {
  cloud_type   = 16
  name         = "av-${var.oci_region}-spoke-vcn"
  region       = var.oci_region
  cidr         = var.oci_spoke_cidr
  account_name = var.oci_account_name
}

# Single OCI Spoke Gateway 
resource "aviatrix_spoke_gateway" "oci_spoke_gw" {
  count              = var.ha_gw ? 0 : 1
  gw_name            = "${var.oci_region}-spoke"
  vpc_id             = aviatrix_vpc.oci_spoke_vcn.name
  cloud_type         = 16
  vpc_reg            = var.oci_region
  enable_active_mesh = true
  gw_size            = var.oci_gw_size
  account_name       = var.oci_account_name
  subnet             = aviatrix_vpc.oci_spoke_vcn.subnets[0].cidr
  allocate_new_eip   = false
}

# HA OCI Spoke Gateway 
resource "aviatrix_spoke_gateway" "oci_spoke_hagw" {
  count              = var.ha_gw ? 1 : 0
  gw_name            = "${var.oci_region}-spoke"
  vpc_id             = aviatrix_vpc.oci_spoke_vcn.name
  cloud_type         = 16
  vpc_reg            = var.oci_region
  enable_active_mesh = true
  gw_size            = var.oci_gw_size
  account_name       = var.oci_account_name
  subnet             = aviatrix_vpc.oci_spoke_vcn.subnets[0].cidr
  ha_subnet             = aviatrix_vpc.oci_spoke_vcn.subnets[0].cidr
  allocate_new_eip   = false
  ha_gw_size         = var.oci_gw_size
}