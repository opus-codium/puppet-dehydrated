require 'spec_helper'

describe 'dehydrated::apache' do
  let(:facts) do
    {
      'os' => {
        'family' => 'FreeBSD',
      },
      'osfamily' => 'FreeBSD',
      'operatingsystem' => 'FreeBSD',
      'operatingsystemrelease' => '11.1-STABLE',
    }
  end

  it { is_expected.to compile.with_all_deps }
end
