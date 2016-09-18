class letsencrypt_sh::params {
  $user = 'letsencrypt'
  $config = 'config'

  case $::osfamily {
    'Debian': {
      $apache_user = 'www-data'
      $etcdir = '/home/letsencrypt'
      $bin = '/home/letsencrypt/letsencrypt.sh'
    }
    'FreeBSD': {
      $apache_user = 'www'
      $bin = '/usr/local/bin/letsencrypt.sh'
      $package = 'letsencrypt.sh'
      $etcdir = '/usr/local/etc/letsencrypt.sh'
    }
  }
}
