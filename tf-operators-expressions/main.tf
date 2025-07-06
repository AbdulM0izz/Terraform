terraform {}

#number list
variable "number_list" {
    type = list(number)
    default = [ 0 ,1,2,3,4,5 ]
}


#object list of person
variable "person_list" {
    type = list(object({
      name = string
      age = number
    }))
  default = [ {
    name = "moiz",
    age = 20
  }, {
    name = "ali",
    age = 50
  } ]
}

#map 
variable "map_list" {
  type = map(number)
  default = {
    "name" = 1
    "age" = 2
    "height" = 5
  }
}

output "name" {
  value =  var.person_list
}