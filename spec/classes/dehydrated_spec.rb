require 'spec_helper'

describe 'dehydrated' do
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
      'contact_email' => 'user@example.com',
    }
  end

  it { is_expected.to compile.with_all_deps }
end
