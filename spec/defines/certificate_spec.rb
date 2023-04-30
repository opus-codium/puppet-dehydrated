# frozen_string_literal: true

require 'spec_helper'

describe 'dehydrated::certificate' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:title) { 'example.com' }

      let(:facts) { facts }

      let(:params) do
        {
          'domains' => domains,
        }
      end

      let(:domains) { :undef }

      it { is_expected.to compile.with_all_deps }

      context 'Subject Alternative Name' do
        let(:domains) { ['www.example.com', 'example.net', 'login.example.net'] }

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
