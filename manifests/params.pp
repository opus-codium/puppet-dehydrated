class dehydrated::params {
  $user = 'dehydrated'
  $previous_user = 'letsencrypt'
  $config = 'config'

  case $::osfamily {
    'Debian': {
      $apache_user = 'www-data'
      $bin = '/home/dehydrated/dehydrated'
      $etcdir = '/home/dehydrated'
      $previous_etcdir = '/home/letsencrypt'
      $package = undef
    }
    'FreeBSD': {
      $apache_user = 'www'
      $bin = '/usr/local/bin/dehydrated'
      $etcdir = '/usr/local/etc/dehydrated'
      $previous_etcdir = '/usr/local/etc/letsencrypt.sh'
      $package = 'dehydrated'
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }
}
