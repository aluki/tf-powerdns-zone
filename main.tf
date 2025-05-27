resource "powerdns_zone" "this" {
  name = var.zone
  kind = var.zone_type
  masters = var.masters
}
