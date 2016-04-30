define letsencrypt_sh::certificate (
  $domains = [],
) {
  include letsencrypt_sh

  concat::fragment { "${letsencrypt_sh::etcdir}/domains.txt-${name}":
    target  => "${letsencrypt_sh::etcdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  # FIXME: Any certificate change should trigger a single `letsencrypt.sh -c`.
  # This exec statement serve as a proxy to determine if this command should be
  # run for this certificate and only then notify the changed exec statement.
  exec { "letsencrypt_sh-${name}":
    command => '/usr/bin/true',
    unless  => "/bin/test -r ${letsencrypt_sh::etcdir}/certs/${name}/cert.pem",
    user    => $letsencrypt_sh::user,
    notify  => Class['letsencrypt_sh::changed'],
  }
}
