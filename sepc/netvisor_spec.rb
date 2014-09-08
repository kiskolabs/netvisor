require "spec_helper"

describe Netvisor do
  describe "#configure" do
    before do
      Netvisor.configure do |config|
        config.build_url = 'http://foo.bar'
      end
    end

    it "returns a url for foo.bar" do
      url = Netvisor::Request.build_url('baz', nil, nil))

      expect(url).to be_a(String)
      expect(url).to eq('http://foo.bar/baz.nv')
    end
  end
end
