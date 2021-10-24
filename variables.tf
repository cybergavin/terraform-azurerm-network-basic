variable "region-name" {
  type        = string
  description = "(Required) The name of the Azure region that will contain the VNets and subnets"
}
variable "network-resource-group" {
  type        = string
  description = "(Required) The name of the resource group that will contain the VNets and subnets"
}
variable "networks" {
  type        = map(any)
  description = "(Required) A map of VNets"
}
variable "global-tags" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resources"
  default     = {}
}