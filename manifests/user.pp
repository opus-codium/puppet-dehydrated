class letsencrypt_sh::user {
  include letsencrypt_sh

  user { $letsencrypt_sh::user:
    ensure     => present,
    system     => true,
    home       => $letsencrypt_sh::etcdir,
    managehome => false, # We do not want /etc/skel files.
  }

  file { $letsencrypt_sh::etcdir:
    ensure => directory,
    owner  => $letsencrypt_sh::user,
    group  => $letsencrypt_sh::apache_user,
    mode   => '0710',
  }

  User[$letsencrypt_sh::user] ->
  File[$letsencrypt_sh::etcdir]

  if $letsencrypt_sh::previous_etcdir {
    exec { 'letsencrypt_sh-migrate-previous-data':
      path        => '/bin:/usr/bin',
      command     => "mv ${letsencrypt_sh::previous_etcdir} ${letsencrypt_sh::etcdir} && chown -R ${letsencrypt_sh::user}:${letsencrypt_sh::user} ${letsencrypt_sh::etcdir} && ln -s ${letsencrypt_sh::etcdir} ${letsencrypt_sh::previous_etcdir}",
      refreshonly => true,
      onlyif      => "[ -d '${letsencrypt_sh::previous_etcdir}' -a ! -h '${letsencrypt_sh::previous_etcdir}' ]",
    }

    User[$letsencrypt_sh::user] ~>
    Exec['letsencrypt_sh-migrate-previous-data'] ->
    File[$letsencrypt_sh::etcdir]
  }

  if $letsencrypt_sh::previous_user {
    user { $letsencrypt_sh::previous_user:
      ensure => absent,
    }
  }
}
