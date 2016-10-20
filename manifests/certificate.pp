define letsencrypt_sh::certificate (
  $domains = [],
) {
  include letsencrypt_sh

  concat::fragment { "${letsencrypt_sh::etcdir}/domains.txt-${name}":
    target  => "${letsencrypt_sh::etcdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  # FIXME: Any certificate change should trigger a single `dehydrated -c`.
  # This exec statement serve as a proxy to determine if this command should be
  # run for this certificate and only then notify the changed exec statement.
  exec { "letsencrypt_sh-${name}":
    command => 'true',
    unless  => "test -r ${letsencrypt_sh::etcdir}/certs/${name}/cert.pem",
    path    => '/bin:/usr/bin',
    user    => $letsencrypt_sh::user,
    notify  => Class['letsencrypt_sh::changed'],
  }
}
