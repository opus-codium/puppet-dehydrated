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

  User[$dehydrated::user] ->
  File[$dehydrated::etcdir]

  if $dehydrated::previous_etcdir {
    exec { 'dehydrated-migrate-previous-data':
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      command     => "mv ${dehydrated::previous_etcdir} ${dehydrated::etcdir} && chown -R ${dehydrated::user}:${dehydrated::user} ${dehydrated::etcdir} && ln -s ${dehydrated::etcdir} ${dehydrated::previous_etcdir}",
      refreshonly => true,
      onlyif      => "[ -d '${dehydrated::previous_etcdir}' -a ! -h '${dehydrated::previous_etcdir}' ]",
    }

    User[$dehydrated::user] ~>
    Exec['dehydrated-migrate-previous-data'] ->
    File[$dehydrated::etcdir]
  }

  if $dehydrated::previous_user {
    user { $dehydrated::previous_user:
      ensure => absent,
    }
  }
}
