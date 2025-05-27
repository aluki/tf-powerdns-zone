provider "powerdns" {
  server_url = "http://dns.test"
  api_key = "key"
}

variables {
  zone = "module-test."
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

run "zone_type_master" {
  command = plan

  variables {
    zone_type = "Master"
  }
}

run "zone_type_slave" {
  command = plan

  variables {
    zone_type = "Slave"
  }
}

run "zone_type_slave_with_null_masters" {
  command = plan

  variables {
    zone_type = "Slave"
    masters = null
  }
}

run "zone_type_slave_with_no_masters" {
  command = plan

  variables {
    zone_type = "Slave"
    masters = []
  }
}

run "zone_type_slave_with_master" {
  command = plan

  variables {
    zone_type = "Slave"
    masters = ["10.0.0.1"]
  }
}
