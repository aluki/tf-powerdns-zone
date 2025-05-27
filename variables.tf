variable "zone" {
  description = "The DNS zone to create. Must be absolute, i.e., end in dot. Example: test."
  type = string
  nullable = false

  validation {
    condition = endswith(var.zone, ".")
    error_message = "The zone must be absolute and end in dot"
  }
}

variable "zone_type" {
  description = "The zone type. It may be Naster or Slave."
  type = string
  nullable = false
  default = "Master"

  validation {
    condition = contains(["Master", "Slave"], var.zone_type)
    error_message = "The zone_type can only be 'Master' or 'Slave', not ${var.zone_type}"
  }
}

variable "masters" {
  description = "The list of masters for a Slave zone. Must be IPs. Example: ['192.168.0.1'], Default: []"
  type = list(string)
  nullable = false
  default = []
}
