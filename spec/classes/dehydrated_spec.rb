require 'spec_helper'

describe 'dehydrated' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      let(:params) do
        {
          'contact_email'     => 'bob@example.com',
          'private_key_renew' => private_key_renew,
        }
      end

      let(:private_key_renew) { :undef }

      it { is_expected.to compile.with_all_deps }

      case facts[:osfamily]
      when 'Debian'
        it { is_expected.to contain_package('curl').with(ensure: 'present') }
      when 'FreeBSD'
        it do
          is_expected.to contain_file('/usr/local/etc/dehydrated/config').without_content(/^PRIVATE_KEY_RENEW=/)
        end

        context('private_key_renew') do
          context('true') do
            let(:private_key_renew) { true }

            it do
              is_expected.to contain_file('/usr/local/etc/dehydrated/config').with_content(/^PRIVATE_KEY_RENEW='yes'$/)
            end
          end
          context('false') do
            let(:private_key_renew) { false }

            it do
              is_expected.to contain_file('/usr/local/etc/dehydrated/config').with_content(/^PRIVATE_KEY_RENEW='no'$/)
            end
          end
        end
      end
    end
  end
end
