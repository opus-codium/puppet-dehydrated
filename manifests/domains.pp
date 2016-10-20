class dehydrated::domains {
  concat { "${dehydrated::etcdir}/domains.txt":
    ensure => present,
    owner  => $dehydrated::user,
    group  => $dehydrated::group,
    mode   => '0644',
  }
}
