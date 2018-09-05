variable "global" {
  description = "Include global cidr blocks also"
  default     = true
}

variable "regions" {
  description = "List of regions to return cidr blocks for"
  default     = [""]
}
