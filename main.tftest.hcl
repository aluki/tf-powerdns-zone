provider "powerdns" {
  server_url = "http://dns.test"
  api_key = "key"
}

variables {
  zone = "module-test."
  dns_host = "192.168.49.2"
  dns_port = "32053"
}

run "try_relative_name_is_not_accpeted" {
  command = plan

  variables {
    zone = "test"
  }

  expect_failures = [
    var.zone
  ]
}

run "zone_name_absolute" {
  command = plan

  variables {
    zone = "test."
  }
}

run "basic_zone" {
  assert {
    condition = powerdns_zone.this.name == var.zone
    error_message = "Error creating the basic zone"
  }

  assert {
    condition = powerdns_zone.this.kind == "Master"
    error_message = "The zone type is"
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
