# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'dehydrated class' do
  it 'works idempotently with no errors' do
    # Install pebble to have a local ACME server
    shell('wget -O - https://github.com/letsencrypt/pebble/archive/refs/tags/v2.3.1.tar.gz | tar zxf - -C /tmp')
    shell('wget -O /tmp/pebble-2.3.1/pebble https://github.com/letsencrypt/pebble/releases/download/v2.3.1/pebble_linux-amd64')
    shell('chmod +x /tmp/pebble-2.3.1/pebble')
    shell('printf \'[Service]\\nExecStart=/tmp/pebble-2.3.1/pebble\\nWorkingDirectory=/tmp/pebble-2.3.1\\n[Install]\\nWantedBy=multi-user.target\\n\' > /etc/systemd/system/pebble.service')
    shell('systemctl daemon-reload')
    shell('systemctl start pebble')
    # Add the test CA to the trust store
    shell('cp /tmp/pebble-2.3.1/test/certs/pebble.minica.pem /usr/local/share/ca-certificates/pebble.minica.crt')
    shell('update-ca-certificates')

    options[:forge_host] = 'https://forge.puppet.com'
    # Version 6.0.0 dropped support for Puppet 6
    # TODO: remove specific version selection when we drop support for Puppet 6
    shell('puppet module install puppetlabs-vcsrepo --version 5.5.0')

    pp = <<~MANIFEST
      package { 'git':
        ensure => present,
      }

      class { 'dehydrated':
        ca            => 'https://localhost:14000/dir', # We do not want to reach real infra
        contact_email => 'sysadmins@example.com',
      }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end
end
