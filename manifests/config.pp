# @summary Manage dehydrated configuration
class dehydrated::config {
  assert_private()

  file { "${dehydrated::etcdir}/config":
    ensure  => present,
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

  ensure_packages($dehydrated::dependencies, { ensure => 'present' })
}
