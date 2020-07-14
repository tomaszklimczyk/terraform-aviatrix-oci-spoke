output "oci_transit_vcn" {
  description = "The full Spoke OCI VCN object"
  value       = aviatrix_vpc.oci_spoke_vcn
}

/*output "oci_spoke_gateway" {
  description = "The full Aviatrix OCI Spoke Gateway object"
  value = var.ha_gw ? aviatrix_spoke_gateway.oci_spoke_hagw[0] : aviatrix_spoke_gateway.oci_spoke_gw[0]
}
*/