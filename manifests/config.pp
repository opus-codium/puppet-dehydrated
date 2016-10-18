class letsencrypt_sh::config {
  file { "${letsencrypt_sh::etcdir}/${letsencrypt_sh::config}":
    ensure  => present,
    owner   => $letsencrypt_sh::user,
    group   => $letsencrypt_sh::user,
    content => "CONTACT_EMAIL=${letsencrypt_sh::contact_email}\nWELLKNOWN=${letsencrypt_sh::etcdir}/.acme-challenges\n",
  }

  file { "${letsencrypt_sh::etcdir}/.acme-challenges":
    ensure  => directory,
    owner   => $letsencrypt_sh::user,
    group   => $letsencrypt_sh::user,
    mode    => '0755',
  }
}
