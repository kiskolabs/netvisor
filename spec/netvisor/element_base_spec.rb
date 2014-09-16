require "spec_helper"

module Netvisor

  class Dummy
    include HappyMapper
    include ElementBase

    attribute :foo, String
    element :bar, String
  end

  describe ElementBase do
    describe "#initialize" do
      it "Class values are nil on no parameters" do
        dummy = Dummy.new
        expect(dummy.foo).to be_nil
        expect(dummy.bar).to be_nil
      end

      it "Class attribute is set to specified value" do
        dummy = Dummy.new(:foo => 'foo')
        expect(dummy.foo).to eq 'foo'
        expect(dummy.bar).to be_nil
      end
    end
  end
end
