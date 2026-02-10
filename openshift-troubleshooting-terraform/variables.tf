
variable "kubeconfig_path" {
  description = "Path to your kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "Namespace to deploy the lab into"
  type        = string
  default     = "troubleshooting-lab"
}
