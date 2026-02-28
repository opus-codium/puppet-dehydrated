# frozen_string_literal: true

require 'spec_helper'

describe 'dehydrated::cron' do
  let(:pre_condition) do
    <<~PP
      class { 'dehydrated':
        contact_email    => 'dummy@example.com',
        renewal_provider => 'cron',
      }
    PP
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.with_all_deps }

      if facts[:os]['family'] == 'Debian'
        it { is_expected.to contain_cron('daily_dehydrated') }
        it { is_expected.to contain_cron('weekly_dehydrated') }
      end
    end
  end
end
