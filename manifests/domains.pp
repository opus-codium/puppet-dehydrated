# @summary Manage the domains.txt file
#
# @api private
class dehydrated::domains {
  assert_private()

  concat { "${dehydrated::etcdir}/domains.txt":
    ensure => present,
    owner  => $dehydrated::user,
    group  => $dehydrated::group,
    mode   => '0644',
  }
}
