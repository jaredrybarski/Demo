variable "namespace" {
  type = string
}

variable "vpc" {
  type = string
}

variable key_name {
  type = string
}

variable "sg_pub_id" {
  type = any
}

variable "sg_priv_id" {
  type = any
}

variable "public_subnets" {
  type = any
}
variable "private_subnets" {
  type = any
}