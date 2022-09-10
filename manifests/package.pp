# @summary Manage the dehydrated package
#
# @api private
class dehydrated::package {
  assert_private()

  package { $dehydrated::package:
    ensure => installed,
  }
}
