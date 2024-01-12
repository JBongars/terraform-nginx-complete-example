data "aws_availability_zones" "available" {}


# get cidr response json from https://FDQN/vendip
# the url appears to be broken but this is how you would do it
# will use a variable for now

# data "http" "vendip" {
#   url = "https://FDQN/vend_ip"
# }

# locals {
#   cidr = "${
#     jsondecode(data.http.vendip.body).ip_address
#     }${
#     jsondecode(data.http.vendip.body).subnet_size
#   }"
# }
