class dehydrated (
  $contact_email,

  $apache_integration = false,
  $cron_integration = false,

  $user = $dehydrated::params::user,
  $previous_user = $dehydrated::params::previous_user,
  $config = $dehydrated::params::config,
  $apache_user = $dehydrated::params::apache_user,
  $bin = $dehydrated::bin,
  $etcdir = $dehydrated::etcdir,
  $previous_etcdir = $dehydrated::previous_etcdir,
  $package = $dehydrated::params::package,
) inherits dehydrated::params {

  include dehydrated::user
  if $package {
    include dehydrated::package

    Class['dehydrated::user'] ->
    Class['dehydrated::package'] ->
    Class['dehydrated::config']
  } else {
    include dehydrated::repo

    Class['dehydrated::user'] ->
    Class['dehydrated::repo'] ->
    Class['dehydrated::config']
  }
  include dehydrated::config
  include dehydrated::domains
  include dehydrated::changed

  Class['dehydrated::config'] ->
  Class['dehydrated::domains'] ->
  Class['dehydrated::changed']

  Class['dehydrated::domains'] ~>
  Class['dehydrated::changed']

  if $apache_integration {
    include dehydrated::apache
  }

  include dehydrated::cron
}
