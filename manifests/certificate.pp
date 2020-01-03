# @summary Add a certificate to manage
#
# @param domains List of Subject Alternative Names to include in the certificate
define dehydrated::certificate (
  Array[String] $domains = [],
) {
  include dehydrated

  concat::fragment { "${dehydrated::etcdir}/domains.txt-${name}":
    target  => "${dehydrated::etcdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  # FIXME: Any certificate change should trigger a single `dehydrated -c`.
  # This exec statement serve as a proxy to determine if this command should be
  # run for this certificate and only then notify the changed exec statement.
  exec { "dehydrated-${name}":
    command => 'true',                   # lint:ignore:quoted_booleans
    unless  => "test -r ${dehydrated::etcdir}/certs/${name}/cert.pem",
    path    => '/bin:/usr/bin',
    user    => $dehydrated::user,
  }

  Class['Dehydrated::Domains']
  -> Exec["dehydrated-${name}"]
  ~> Class['Dehydrated::Changed']
}
