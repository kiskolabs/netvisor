require 'spec_helper'

describe Netvisor do
  describe "#configure" do
    before do
      Netvisor.configure do |config|
        config.host = 'http://foo.bar'
      end
    end

    it "returns a url for foo.bar" do
      url = Netvisor::Request.build_url('baz', {})

      expect(url).to be_a(String)
      expect(url).to eq('http://foo.bar/baz.nv')
    end

    after :each do
      Netvisor.reset
    end
  end

  describe ".reset" do
    before :each do
      Netvisor.configure do |config|
        config.host = 'http://foo.bar'
      end
    end

    it "resets the configuration" do
      Netvisor.reset

      config = Netvisor.configuration

      expect(config.host).to eq(nil)
    end
  end
end
