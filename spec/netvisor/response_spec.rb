require "spec_helper"

module Netvisor


  describe Netvisor::Response do
    let(:xml) do
      <<-XML
<?xml version=\"1.0\"?>\n<Root>\n  <ResponseStatus>\n    <Status>OK</Status>\n    <TimeStamp>2025-06-11T20:04:58+00:00</TimeStamp>\n  </ResponseStatus>\n  <SalesInvoice>\n    <SalesInvoiceNumber>300244621</SalesInvoiceNumber>\n    <SalesInvoiceDate>2025-06-06</SalesInvoiceDate>\n    <SalesInvoiceAmount>560,1</SalesInvoiceAmount>\n    <InvoiceStatus>Avoin</InvoiceStatus>\n    <InvoicingCustomerName>Martikainen Laura</InvoicingCustomerName>\n    <InvoicingCustomerNetvisorKey>13225</InvoicingCustomerNetvisorKey>\n    <InvoiceLines>\n      <InvoiceLine>\n        <SalesInvoiceProductLine>\n          <ProductName>Vakuusmaksu: Kangastuvankatu 6 A 11/2</ProductName>\n          <ProductUnitPrice>560,1</ProductUnitPrice>\n          <ProductVatPercentage vatcode=\"-\">0</ProductVatPercentage>\n          <SalesInvoiceProductLineQuantity>1</SalesInvoiceProductLineQuantity>\n          <SalesInvoiceProductLineDiscountPercentage>0</SalesInvoiceProductLineDiscountPercentage>\n          <SalesInvoiceProductLineFreeText/>\n          <SalesInvoiceProductLineVatSum>0.0</SalesInvoiceProductLineVatSum>\n          <SalesInvoiceProductLineSum>560,1</SalesInvoiceProductLineSum>\n          <AccountingAccountSuggestion>520</AccountingAccountSuggestion>\n          <dimension/>\n        </SalesInvoiceProductLine>\n      </InvoiceLine>\n    </InvoiceLines>\n  </SalesInvoice>\n</Root>\n
      XML
    end
    let(:response) { Netvisor::Response.parse(xml) }

    describe "Float with comma parsing" do
      it "parses float values with commas" do
        expect(response.sales_invoice.sales_invoice_amount).to eq(560.1)
      end
    end
  end
end
