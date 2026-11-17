require "spec_helper"

module Netvisor
  describe Request do
    describe ".build_headers" do
      let(:url) { "https://example.test/x.nv" }

      before do
        allow(Time).to receive(:now).and_return(Time.at(1_700_000_000, 123, :millisecond))
      end

      it "gives requests made in the same millisecond different UUID transaction ids" do
        ids = Array.new(50) { Request.build_headers(url)["X-Netvisor-Authentication-TransactionId"] }

        expect(ids.uniq.size).to eq(50)
        expect(ids).to all(match(/\A\h{8}-\h{4}-4\h{3}-[89ab]\h{3}-\h{12}\z/))
      end

      it "signs the transaction id it sends" do
        allow(SecureRandom).to receive(:uuid).and_return("0f8fad5b-d9cb-469f-a165-70867728950e")

        headers = Request.build_headers(url)

        expect(headers["X-Netvisor-Authentication-TransactionId"]).to eq("0f8fad5b-d9cb-469f-a165-70867728950e")
        expect(headers["X-Netvisor-Authentication-MAC"]).to eq(
          Request.build_mac(url, headers["X-Netvisor-Authentication-Timestamp"], "0f8fad5b-d9cb-469f-a165-70867728950e", headers["X-Netvisor-Authentication-TimestampUnix"])
        )
      end
    end

    describe ".build_mac" do
      it "hashes the fields in Netvisor's documented order with CustomerKey&PartnerKey as the key" do
        config = Netvisor.configuration
        config.sender = "Sender"
        config.customer_id = "CustomerId"
        config.language = "FI"
        config.organisation_id = "OrganisationId"
        config.customer_key = "CustomerKey"
        config.partner_key = "PartnerKey"

        data = "https://example.test/x.nv&Sender&CustomerId&2023-11-14 22:13:20.123&FI&OrganisationId&0f8fad5b-d9cb-469f-a165-70867728950e&1700000000&CustomerKey&PartnerKey"
        expected = OpenSSL::HMAC.hexdigest("SHA256", "CustomerKey&PartnerKey", data)

        expect(Request.build_mac("https://example.test/x.nv", "2023-11-14 22:13:20.123", "0f8fad5b-d9cb-469f-a165-70867728950e", "1700000000")).to eq(expected)
      end
    end
  end
end
