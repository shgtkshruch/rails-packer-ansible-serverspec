require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
end

describe port(80) do
  it { should be_listening }
end

describe command('ruby --version') do
  its(:stdout) { should match /3.0.0/ }
end

describe command('node --version') do
  its(:stdout) { should match /v14.15.3/ }
end
