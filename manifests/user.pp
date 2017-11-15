class dehydrated::user {
  include dehydrated

  user { $dehydrated::user:
    ensure     => present,
    system     => true,
    home       => $dehydrated::etcdir,
    managehome => false, # We do not want /etc/skel files.
  }

  file { $dehydrated::etcdir:
    ensure => directory,
    owner  => $dehydrated::user,
    group  => $dehydrated::apache_user,
    mode   => '0710',
  }

  User[$dehydrated::user]
  -> File[$dehydrated::etcdir]
}
