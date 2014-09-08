require "spec_helper"

module Netvisor
  describe Configuration do
    describe "#host" do
      it "default value is nil" do
        Configuration.new.host = 'http://foo.bar'
      end
    end

    describe "#host=" do
      it "can set value" do
        config = Configuration.new
        config.host = 'http://foo.bar'
        expect(config.host).to eq('http://foo.bar')
      end
    end
  end
end
