provider "powerdns" {
  server_url = "http://dns.test"
  api_key = "key"
}

variables {
  zone = "module-test."
  dns_host = "192.168.49.2"
  dns_port = "32053"
}

run "basic_zone" {
  assert {
    condition = powerdns_zone.this.name == var.zone
    error_message = "Error creating the basic zone"
  }

  assert {
    condition = powerdns_zone.this.kind == "Master"
    error_message = "The zone type is not master, it is '${powerdns_zone.this.kind}'"
  }
}

run "zone_type_master" {
  variables {
    zone_type = "Master"
  }

  assert {
    condition = resource.powerdns_zone.this.kind == "Master"
    error_message = "The zone_type should be 'Master', but it is ${resource.powerdns_zone.this.kind}"
  }
}

run "query_wiht_udp" {
  module {
    source = "./test_ports"
  }

  assert {
    condition = data.external.soa_udp.result.result == "0"
    error_message = "Unable to query with UDP"
  }
}

run "query_with_tcp" {
  module {
    source = "./test_ports"
  }

  assert {
    condition = data.external.soa_tcp.result.result == "0"
    error_message = "Unable to query with TCP"
  }
}

run "check_soa_existence" {
  module {
    source = "./test_ports"
  }

  assert {
    condition = data.external.soa_udp.result.answers == "1"
    error_message = "Mismatch number of answers. Sould be 1 and they are ${data.external.soa_udp.result.answers}"
  }
}

run "check_there_is_no_a_record" {
  module {
    source = "./test_ports"
  }

  assert {
    condition = data.external.a_udp.result.answers == "0"
    error_message = "Mismatch number of answers. Sould be 0 and they are ${data.external.soa_udp.result.answers}"
  }

}
