class letsencrypt_sh::user {
  include letsencrypt_sh

  user { $letsencrypt_sh::user:
    ensure     => present,
    system     => true,
    home       => $letsencrypt_sh::etcdir,
    managehome => false, # We do not want /etc/skel files.
  } ->
  file { $letsencrypt_sh::etcdir:
    ensure => directory,
    owner  => $letsencrypt_sh::user,
    group  => $letsencrypt_sh::apache_user,
    mode   => '0710',
  }
}
