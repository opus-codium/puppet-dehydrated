require 'spec_helper'

describe 'dehydrated' do
  let(:facts) do
    {
      'os' => {
        'family' => 'FreeBSD',
      }
    }
  end

  let(:params) do
    {
      'contact_email' => 'bob@example.com',
      'private_key_renew' => private_key_renew,
    }
  end

  let(:private_key_renew) { :undef }

  it { is_expected.to compile.with_all_deps }

  it do
    is_expected.to contain_file('/usr/local/etc/dehydrated/config').without_content(/^PRIVATE_KEY_RENEW=/)
  end

  context('with XXX set') do
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
