# @summary Manage the dehydrated package
class dehydrated::package {
  assert_private()

  package { $dehydrated::package:
    ensure => installed,
  }
}
