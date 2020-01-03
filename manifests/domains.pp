# @summary Manage the domains.txt file
class dehydrated::domains {
  include dehydrated

  concat { "${dehydrated::etcdir}/domains.txt":
    ensure => present,
    owner  => $dehydrated::user,
    group  => $dehydrated::group,
    mode   => '0644',
  }
}
