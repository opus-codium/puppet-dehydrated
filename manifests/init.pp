class letsencrypt_sh (
  $contact_email,
  $user = $letsencrypt_sh::params::user,
  $apache_integration = false,
  $cron_integration = false,
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

  Class['letsencrypt_sh::config'] ->
  Class['letsencrypt_sh::domains']

  if $apache_integration {
    include letsencrypt_sh::apache
  }

  include letsencrypt_sh::cron
}
