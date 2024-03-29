# @summary Trigger a refresh of the certificates
#
# @api private
class dehydrated::changed {
  assert_private()

  exec { "${dehydrated::bin} --accept-terms -c":
    refreshonly => true,
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => $dehydrated::user,
    timeout     => $dehydrated::timeout,
  }

  if $dehydrated::apache_integration {
    Class['Apache::Service']
    -> Exec["${dehydrated::bin} --accept-terms -c"]
  }
}
