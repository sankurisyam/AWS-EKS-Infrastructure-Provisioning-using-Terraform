variable "name" {
  type = string
}

variable "kubernetes_version"{
    type = string

}

variable "cluster_role_arn"{
    type = string
}

variable "private_subnets"{
    type = list(string)
}

variable "node_role_arn"{
    type = string
}

variable "vpc_cni_addon"{
    type = string
}
variable "core_dns_addon"{
    type = string
}
variable "kube_proxy_addon"{
    type = string
}