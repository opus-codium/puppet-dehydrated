class dehydrated::cron {
  include ::dehydrated

  if $dehydrated::cron_integration {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  case $facts['os']['family'] {
    'Debian': {
      cron { 'weekly_letsencrypt':
        ensure  => absent,
      }
      cron { 'weekly_dehydrated':
        ensure  => $ensure,
        command => "${dehydrated::bin} --accept-terms -c",
        user    => $dehydrated::user,
        weekday => 0,
        hour    => 3,
        minute  => 30,
      }
    }
    'FreeBSD': {
      file_line { 'weekly_dehydrated_enable':
        ensure => $ensure,
        path   => '/etc/periodic.conf',
        line   => 'weekly_dehydrated_enable="YES"',
        match  => '^weekly_(letsencrypt|dehydrated)_enable=',
      }
      file_line { 'weekly_dehydrated_user':
        ensure => $ensure,
        path   => '/etc/periodic.conf',
        line   => "weekly_dehydrated_user=\"${dehydrated::user}\"",
        match  => '^weekly_(letsencrypt|dehydrated)_user=',
      }
    }
    default: {
      fail("Unsupported osfamily ${facts['os']['family']}")
    }
  }
}
