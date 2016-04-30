class letsencrypt_sh::changed {
  include letsencrypt_sh

  exec { "${letsencrypt_sh::bin} -c":
    refreshonly => true,
    path        => '/bin:/usr/bin:/usr/local/bin',
  }
}
