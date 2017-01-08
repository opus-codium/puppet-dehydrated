class dehydrated::config {
  include ::dehydrated

  file { "${dehydrated::etcdir}/${dehydrated::config}":
    ensure  => present,
    owner   => $dehydrated::user,
    group   => $dehydrated::user,
    content => "CONTACT_EMAIL=${dehydrated::contact_email}\nWELLKNOWN=${dehydrated::etcdir}/.acme-challenges\n",
  }

  file { "${dehydrated::etcdir}/.acme-challenges":
    ensure => directory,
    owner  => $dehydrated::user,
    group  => $dehydrated::user,
    mode   => '0755',
  }
}
