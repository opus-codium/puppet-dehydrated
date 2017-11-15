class dehydrated::config {
  include dehydrated

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
}
