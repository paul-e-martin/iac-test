output "aks_id" {
  value = azurerm_kubernetes_cluster.k8s_cluster.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.k8s_cluster.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.k8s_cluster.node_resource_group
}

output "kubelet_identity_object_id" {
  description = "The Object ID of the user-defined Managed Identity assigned to the Kubelets"
  value       = azurerm_kubernetes_cluster.k8s_cluster.kubelet_identity[0].object_id
}
