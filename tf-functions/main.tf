terraform {}

locals {
  value = "Hello world"
}

variable "string_list" {
  type = list(string)
  default = [ "ser1", "ser2" ,"ser3" ]
}

output "name" {
#   value = lower(local.value)
# value = upper(local.value)
# value = startswith(local.value, "Hello")
value = length(var.string_list)

}
