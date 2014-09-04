require 'happymapper'
require 'netvisor/sales_invoice'

module Netvisor
  class Root
    include HappyMapper

    tag self.name.split('::').last
    has_one :sales_invoice, SalesInvoice, :tag => 'SalesInvoice'

  end
end
