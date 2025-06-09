locals {
  spfile = jsondecode(file("../../secrets/sp.json"))
}