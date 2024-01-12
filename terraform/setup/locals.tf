locals {
  principals = concat(
    var.principals,
    var.elect_self_as_principal ? [data.aws_caller_identity.current.account_id] : []
  )
}
