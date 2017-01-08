class dehydrated::changed {
  include ::dehydrated

  exec { "${dehydrated::bin} -c":
    refreshonly => true,
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => $dehydrated::user,
  }

  if $dehydrated::apache_integration {
    Class['Apache::Service'] ->
    Exec["${dehydrated::bin} -c"]
  }
}
