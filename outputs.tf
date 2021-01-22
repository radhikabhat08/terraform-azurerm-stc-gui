# OUTPUTS
output "instance_public_ips" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = azurerm_windows_virtual_machine.stc_gui.*.public_ip_address
}

output "instance_private_ips" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = azurerm_windows_virtual_machine.stc_gui.*.private_ip_address
}

output "instance_ids" {
  description = "List of instance IDs"
  value       = azurerm_windows_virtual_machine.stc_gui.*.id
}