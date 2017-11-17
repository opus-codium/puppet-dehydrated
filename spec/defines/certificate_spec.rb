require 'spec_helper'

describe 'dehydrated::certificate' do
  let(:title) { 'example.com' }

  let(:facts) do
    {
      'os' => {
        'family' => 'FreeBSD',
      }
    }
  end

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
