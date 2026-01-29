# Recent linux distro do not package cron by default
package { 'cron':
  ensure => installed,
}
