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
      $bin = '/usr/local/bin/dehydrated'
      $package = 'dehydrated'
      $etcdir = '/usr/local/etc/dehydrated'
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }
}
