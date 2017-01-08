class dehydrated (
  $contact_email,

  $apache_integration = false,
  $cron_integration   = false,

  $apache_user     = $::dehydrated::params::apache_user,
  $bin             = $::dehydrated::params::bin,
  $config          = $::dehydrated::params::config,
  $etcdir          = $::dehydrated::params::etcdir,
  $package         = $::dehydrated::params::package,
  $previous_etcdir = $::dehydrated::params::previous_etcdir,
  $previous_user   = $::dehydrated::params::previous_user,
  $user            = $::dehydrated::params::user,
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
