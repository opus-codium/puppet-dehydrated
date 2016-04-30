class letsencrypt_sh::apache {
  include letsencrypt_sh

  include apache

  $etcdir = $letsencrypt_sh::etcdir

  apache::custom_config { 'letsencrypt_sh':
    ensure  => present,
    content => template('letsencrypt_sh/apache_alias.conf.erb'),
  }
}
