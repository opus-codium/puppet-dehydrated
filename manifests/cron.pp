class letsencrypt_sh::cron {
  if $letsencrypt_sh::cron_integration {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  case $::osfamily {
    'Debian': {
      cron { 'weekly_letsencrypt':
        ensure  => absent,
      }
      cron { 'weekly_dehydrated':
        ensure  => $ensure,
        command => "${letsencrypt_sh::bin} -c",
        user    => $letsencrypt_sh::user,
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
        line   => "weekly_dehydrated_user=\"${letsencrypt_sh::user}\"",
        match  => '^weekly_(letsencrypt|dehydrated)_user=',
      }
    }
  }
}
