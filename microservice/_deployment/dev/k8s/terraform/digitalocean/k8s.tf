resource "digitalocean_kubernetes_cluster" "echovibe-sgp-k8s-cluster" {
  name   = "echovibe-sgp-k8s-cluster"
  region = "sgp1"
  version = "1.32.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}
