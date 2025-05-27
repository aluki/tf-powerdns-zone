resource "powerdns_zone" "this" {
  name = var.zone
  kind = "Master"
}
