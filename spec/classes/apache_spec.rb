# frozen_string_literal: true

require 'spec_helper'

describe 'dehydrated::apache' do
  let(:pre_condition) do
    <<~PP
      class { 'dehydrated':
        contact_email => 'dummy@example.com',
      }
    PP
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
