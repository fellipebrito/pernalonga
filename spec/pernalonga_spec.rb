require 'spec_helper'

describe Pernalonga do
  it 'has a version number' do
    expect(Pernalonga::VERSION).not_to be nil
  end

  context 'reads the necessary env variables' do
    it 'has a host' do
      expect(ENV['BUNNY_HOST']).to be_truthy
      expect(ENV['BUNNY_VHOST']).to be_truthy
      expect(ENV['BUNNY_USER']).to be_truthy
      expect(ENV['BUNNY_PASSWORD']).to be_truthy
    end
  end
end
