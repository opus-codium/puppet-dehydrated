# @summary Manage cron task to refresh certificates
#
# @api private
class dehydrated::cron {
  assert_private()

  $supported_renewal_intervals = [
    'daily',
    'weekly',
  ]

  case $facts['os']['family'] {
    'Debian', 'RedHat': {
      cron { 'daily_dehydrated':
        ensure  => bool2str($dehydrated::renewal_interval == 'daily', 'present', 'absent'),
        command => "${dehydrated::bin} --accept-terms --cron --keep-going",
        user    => $dehydrated::user,
        weekday => '*',
        hour    => 3,
        minute  => 30,
      }

      cron { 'weekly_dehydrated':
        ensure  => bool2str($dehydrated::renewal_interval == 'weekly', 'present', 'absent'),
        command => "${dehydrated::bin} --accept-terms --cron --keep-going",
        user    => $dehydrated::user,
        weekday => 0,
        hour    => 3,
        minute  => 30,
      }
    }
    'FreeBSD': {
      $supported_renewal_intervals.each |$interval| {
        file_line { "${interval}_dehydrated_enable":
          ensure => bool2str($interval == $dehydrated::renewal_interval, 'present', 'absent'),
          path   => '/etc/periodic.conf',
          line   => "${interval}_dehydrated_enable=\"YES\"",
          match  => "^${interval}_dehydrated_enable=",
        }
        file_line { "${interval}_dehydrated_user":
          ensure => bool2str($interval == $dehydrated::renewal_interval, 'present', 'absent'),
          path   => '/etc/periodic.conf',
          line   => "${interval}_dehydrated_user=\"${dehydrated::user}\"",
          match  => "^${interval}_dehydrated_user=",
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${facts['os']['family']}")
    }
  }
}
