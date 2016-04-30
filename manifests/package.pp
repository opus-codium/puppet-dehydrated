class letsencrypt_sh::package {
  package { $letsencrypt_sh::package:
    ensure => installed,
  }
}
