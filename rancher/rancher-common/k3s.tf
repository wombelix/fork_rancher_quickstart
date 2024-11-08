# K3s cluster for Rancher

resource "ssh_resource" "install_k3s" {
  host = var.node_public_ip
  # Advertise kube apiserver on internal ip (advertise-address), allow access in addition through public ip (tls-san)
  commands = [
    "bash -c 'curl https://get.k3s.io | INSTALL_K3S_EXEC=\"server --node-external-ip ${var.node_public_ip} --node-ip ${var.node_internal_ip} --advertise-address ${var.node_internal_ip} --tls-san ${var.node_public_ip}\" INSTALL_K3S_VERSION=${var.rancher_kubernetes_version} sh -'"
  ]
  user        = var.node_username
  private_key = var.ssh_private_key_pem
}

resource "ssh_resource" "retrieve_config" {
  depends_on = [
    ssh_resource.install_k3s
  ]
  host = var.node_public_ip
  commands = [
    "sudo sed \"s/127.0.0.1/${var.node_public_ip}/g\" /etc/rancher/k3s/k3s.yaml"
  ]
  user        = var.node_username
  private_key = var.ssh_private_key_pem
}
