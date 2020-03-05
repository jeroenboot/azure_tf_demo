variable "location" {}
variable "subscription_id" {}
variable "client_id" {}
variable "client_certificate_path" {}
variable "client_certificate_password" {}
variable "tenant_id" {}
variable "resourcegroup" {}


provider "azurerm" {
  version = "~>2.0.0"
  features {}

  subscription_id = var.subscription_id
  client_id = var.client_id
  client_certificate_path = var.client_certificate_path
  client_certificate_password = var.client_certificate_password
  tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name = var.resourcegroup
  location = var.location
}