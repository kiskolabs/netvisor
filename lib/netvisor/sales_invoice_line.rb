require 'happymapper'
require 'netvisor/sales_invoice_product_line'

module Netvisor
  class SalesInvoiceLine
    include HappyMapper

    tag 'InvoiceLine'

    class SalesInvoiceCommentLine
      include HappyMapper

      tag self.name.split('::').last
      has_one :comment, String, :tag => 'Comment'
    end
    has_one :product_line, SalesInvoiceProductLine
    has_one :comment_line, SalesInvoiceCommentLine
  end
end
