class dehydrated (
  $contact_email,

  $apache_user,
  $bin,
  $config,
  $etcdir,
  $group,
  $package,
  $previous_etcdir,
  $previous_user,
  $user,

  $apache_integration = false,
  $cron_integration   = false,

) {

  include dehydrated::user
  if $package {
    include dehydrated::package

    Class['dehydrated::user']
    -> Class['dehydrated::package']
    -> Class['dehydrated::config']
  } else {
    include dehydrated::repo

    Class['dehydrated::user']
    -> Class['dehydrated::repo']
    -> Class['dehydrated::config']
  }
  include dehydrated::config
  include dehydrated::domains
  include dehydrated::changed

  Class['dehydrated::config']
  -> Class['dehydrated::domains']
  -> Class['dehydrated::changed']

  Class['dehydrated::domains']
  ~> Class['dehydrated::changed']

  if $apache_integration {
    include dehydrated::apache
  }

  include dehydrated::cron
}
