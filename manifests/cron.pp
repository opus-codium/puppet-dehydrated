class letsencrypt_sh::cron {
  if $letsencrypt_sh::cron_integration {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  case $::osfamily {
    'Debian': {
      cron { 'weekly_letsencrypt':
        ensure  => $ensure,
        command => "${letsencrypt_sh::etcdir}/letsencrypt.sh -c",
        user    => $letsencrypt_sh::user,
        weekday => 0,
        hour    => 3,
        minute  => 30,
      }
    }
    'FreeBSD': {
      file_line { 'weekly_letsencrypt_enable':
        ensure => $ensure,
        path   => '/etc/periodic.conf',
        line   => 'weekly_letsencrypt_enable="YES"',
        match  => '^weekly_letsencrypt_enable=',
      }
      file_line { 'weekly_letsencrypt_user':
        ensure => $ensure,
        path   => '/etc/periodic.conf',
        line   => "weekly_letsencrypt_user=\"${letsencrypt_sh::user}\"",
        match  => '^weekly_letsencrypt_user=',
      }
    }
  }
}
