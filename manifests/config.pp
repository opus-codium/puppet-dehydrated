class letsencrypt_sh::config {
  file_line { "${letsencrypt_sh::etcdir}/config.sh-contact_email":
    path  => "${letsencrypt_sh::etcdir}/config.sh",
    line  => "CONTACT_EMAIL=${letsencrypt_sh::contact_email}",
    match => '^#?CONTACT_EMAIL='
  }

  file { "${letsencrypt_sh::etcdir}/.acme-challenges":
    ensure  => directory,
    owner   => $letsencrypt_sh::user,
    group   => $letsencrypt_sh::user,
    mode    => '0755',
  }
}
