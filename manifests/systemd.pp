# @summary Manage a system timer to refresh certificates
#
# @api private
class dehydrated::systemd {
  assert_private()

  systemd::timer { 'dehydrated.timer':
    ensure          => bool2str($dehydrated::renewal_interval != 'never', 'present', 'absent'),
    active          => true,
    enable          => true,
    timer_content   => epp('dehydrated/systemd.timer.epp'),
    service_content => epp('dehydrated/systemd.service.epp'),
  }
}
