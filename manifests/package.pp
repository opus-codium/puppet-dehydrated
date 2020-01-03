# @summary Manage the dehydrated package
class dehydrated::package {
  include dehydrated

  package { $dehydrated::package:
    ensure => installed,
  }
}
