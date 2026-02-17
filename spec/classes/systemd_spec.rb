# frozen_string_literal: true

require 'spec_helper'

describe 'dehydrated::systemd' do
  let(:pre_condition) do
    <<~PP
      class { 'dehydrated':
        contact_email    => 'dummy@example.com',
        renewal_provider => 'systemd',
      }
    PP
  end

  on_supported_os.each do |os, facts|
    next unless facts[:os]['family'] == 'Debian'

    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_systemd__timer('dehydrated.timer') }
    end
  end
end
