class letsencrypt_sh (
  $contact_email,

  $apache_integration = false,
  $cron_integration = false,

  $user = $letsencrypt_sh::params::user,
  $previous_user = $letsencrypt_sh::params::previous_user,
  $config = $letsencrypt_sh::params::config,
  $apache_user = $letsencrypt_sh::params::apache_user,
  $bin = $letsencrypt_sh::bin,
  $etcdir = $letsencrypt_sh::etcdir,
  $previous_etcdir = $letsencrypt_sh::previous_etcdir,
  $package = $letsencrypt_sh::params::package,
) inherits letsencrypt_sh::params {

  include letsencrypt_sh::user
  if $package {
    include letsencrypt_sh::package

    Class['letsencrypt_sh::user'] ->
    Class['letsencrypt_sh::package'] ->
    Class['letsencrypt_sh::config']
  } else {
    include letsencrypt_sh::repo

    Class['letsencrypt_sh::user'] ->
    Class['letsencrypt_sh::repo'] ->
    Class['letsencrypt_sh::config']
  }
  include letsencrypt_sh::config
  include letsencrypt_sh::domains
  include letsencrypt_sh::changed

  Class['letsencrypt_sh::config'] ->
  Class['letsencrypt_sh::domains'] ->
  Class['letsencrypt_sh::changed']

  Class['letsencrypt_sh::domains'] ~>
  Class['letsencrypt_sh::changed']

  if $apache_integration {
    include letsencrypt_sh::apache
  }

  include letsencrypt_sh::cron
}
