class letsencrypt_sh::changed {
  include letsencrypt_sh

  exec { "${letsencrypt_sh::bin} -c":
    refreshonly => true,
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => $letsencrypt_sh::user,
  }

  if $letsencrypt_sh::apache_integration {
    Class['Apache::Service'] ->
    Exec["${letsencrypt_sh::bin} -c"]
  }
}
