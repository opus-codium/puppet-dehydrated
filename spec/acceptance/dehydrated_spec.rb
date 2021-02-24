require 'spec_helper_acceptance'

describe 'certificate_checker class' do
  it 'works idempotently with no errors' do
    options[:forge_host] = 'https://forge.puppet.com'
    puppet_module_install(module_name: 'puppetlabs-vcsrepo')

    pp = <<~MANIFEST
      package { 'git':
        ensure => installed,
      }

      class { 'dehydrated':
        contact_email => 'user@example.com'
      }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end
end
