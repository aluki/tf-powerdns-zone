provider "powerdns" {
  server_url = "http://dns.test"
  api_key = "key"
}

variables {
  zone = "module-test."
  dns_host = "192.168.49.2"
  dns_port = "32053"
}

run "zone_type_slave" {
  variables {
    zone_type = "Slave"
  }

  assert {
    condition = resource.powerdns_zone.this.kind == "Slave"
    error_message = "The zone_type should be 'Slave', but it is ${resource.powerdns_zone.this.kind}"
  }

  assert {
    condition = resource.powerdns_zone.this.masters == null
    error_message = "Masters should be null"
  }

}

run "zone_type_slave_with_null_masters" {
  variables {
    zone_type = "Slave"
    masters = null
  }

  assert {
    condition = resource.powerdns_zone.this.kind == "Slave"
    error_message = "The zone_type should be 'Slave', but it is ${resource.powerdns_zone.this.kind}"
  }

  assert {
    condition = length(resource.powerdns_zone.this.masters) == 0
    error_message = "Masters should be empty, but hast ${length(resource.powerdns_zone.this.masters)} members"
  }

}

run "zone_type_slave_with_no_masters" {
  variables {
    zone_type = "Slave"
    masters = []
  }

  assert {
    condition = resource.powerdns_zone.this.kind == "Slave"
    error_message = "The zone_type should be 'Slave', but it is ${resource.powerdns_zone.this.kind}"
  }

  assert {
    condition = length(resource.powerdns_zone.this.masters) == 0
    error_message = "Masters should be empty, but hast ${length(resource.powerdns_zone.this.masters)} members"
  }

}

run "zone_type_slave_with_master" {
  variables {
    zone_type = "Slave"
    masters = ["10.0.0.1"]
  }

  assert {
    condition = resource.powerdns_zone.this.kind == "Slave"
    error_message = "The zone_type should be 'Slave', but it is ${resource.powerdns_zone.this.kind}"
  }

  assert {
    condition = resource.powerdns_zone.this.masters == toset(["10.0.0.1"])
    error_message = "Masters should be empty, but hast ${length(resource.powerdns_zone.this.masters)} members"
  }

}
