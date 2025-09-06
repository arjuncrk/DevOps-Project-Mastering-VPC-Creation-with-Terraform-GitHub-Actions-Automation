variable "sg_id" {
  description = "Sg id for application loead balancer"
  type = string
}

variable "subnets" {
  description = "subnets for ALB"
  type = list(string)
}

variable "vcp_id" {
  description = "vpc id for alb"
  type = string
}

variable "instances"{
    description = "Instance id for target group attachment"
    type = list(string)
}