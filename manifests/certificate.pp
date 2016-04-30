define letsencrypt_sh::certificate (
  $domains = [],
) {
  include letsencrypt_sh

  concat::fragment { "${letsencrypt_sh::etcdir}/domains.txt-${name}":
    target  => "${letsencrypt_sh::etcdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }
}
