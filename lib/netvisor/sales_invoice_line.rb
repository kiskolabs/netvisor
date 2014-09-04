require 'happymapper'
require 'netvisor/sales_invoice_product_line'

module Netvisor
  class SalesInvoiceLine
    include HappyMapper

    tag 'InvoiceLine'

    has_one :product_line, Netvisor::SalesInvoiceProductLine, :tag => 'SalesInvoiceProductLine'

  end
end
