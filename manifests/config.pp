# @summary Manage dehydrated configuration
#
# @api private
class dehydrated::config {
  assert_private()

  file { "${dehydrated::etcdir}/config":
    ensure  => file,
    owner   => $dehydrated::user,
    group   => $dehydrated::user,
    content => epp('dehydrated/config.epp'),
  }

  file { "${dehydrated::etcdir}/.acme-challenges":
    ensure => directory,
    owner  => $dehydrated::user,
    group  => $dehydrated::user,
    mode   => '0755',
  }

  stdlib::ensure_packages($dehydrated::dependencies, { ensure => 'present' })
}
