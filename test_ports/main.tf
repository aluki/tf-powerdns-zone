data "external" "soa_udp" {
  program = ["sh", "-c", "q -f=json +nord @${var.dns_host}:${var.dns_port} soa ${var.zone} | jq -r '{result: .[0].replies[0].rcode | tostring, answers: .[0].replies[0].answer | length | tostring}'"]
}

data "external" "soa_tcp" {
  program = ["sh", "-c", "q -f=json +nord @tcp://${var.dns_host}:${var.dns_port} soa ${var.zone} | jq -r '{result: .[0].replies[0].rcode | tostring, answers: .[0].replies[0].answer | length | tostring}'"]
}

data "external" "a_udp" {
  program = ["sh", "-c", "q -f=json +nord @${var.dns_host}:${var.dns_port} a ${var.zone} | jq -r '{result: .[0].replies[0].rcode | tostring, answers: .[0].replies[0].answer | length | tostring}'"]
}

