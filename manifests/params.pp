class letsencrypt_sh::params {
  $user = 'letsencrypt'

  case $::osfamily {
    'Debian': {
      $apache_user = 'www-data'
      $etcdir = '/home/letsencrypt'
    }
    'FreeBSD': {
      $apache_user = 'www'
      $package = 'letsencrypt.sh'
      $etcdir = '/usr/local/etc/letsencrypt.sh'
    }
  }
}
