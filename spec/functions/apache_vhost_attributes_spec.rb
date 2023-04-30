# frozen_string_literal: true

require 'spec_helper'

describe 'dehydrated::apache::vhost_attributes' do
  let(:facts) do
    {
      os: {
        family: 'Debian',
      },
    }
  end

  context 'on Debian' do
    let(:pre_condition) do
      <<~PUPPET
        class { 'dehydrated':
          contact_email => 'dummy@example.com',
        }
      PUPPET
    end

    it do
      is_expected.to run.with_params('hostname.example.com').and_return(
        {
          'ssl_cert' => '/home/dehydrated/certs/hostname.example.com/fullchain.pem',
          'ssl_key'  => '/home/dehydrated/certs/hostname.example.com/privkey.pem',
        }
      )
    end
  end

  context 'with custom etcdir' do
    let(:pre_condition) do
      <<~PUPPET
        class { 'dehydrated':
          contact_email => 'dummy@example.com',
          etcdir        => '/custom/etcdir',
        }
      PUPPET
    end

    it do
      is_expected.to run.with_params('hostname.example.com').and_return(
        {
          'ssl_cert' => '/custom/etcdir/certs/hostname.example.com/fullchain.pem',
          'ssl_key'  => '/custom/etcdir/certs/hostname.example.com/privkey.pem',
        }
      )
    end
  end
end
