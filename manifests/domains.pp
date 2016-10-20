class letsencrypt_sh::domains {
  concat { "${letsencrypt_sh::etcdir}/domains.txt":
    ensure => present,
    owner  => $letsencrypt_sh::user,
    group  => $letsencrypt_sh::group,
    mode   => '0644',
  }
}
