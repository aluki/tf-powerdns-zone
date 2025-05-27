variable "zone" {
  description = "The DNS zone to create. Must be absolute, i.e., end in dot. Example: test."
  type = string
  nullable = false

  validation {
    condition = endswith(var.zone, ".")
    error_message = "The zone must be absolute and end in dot"
  }
}


