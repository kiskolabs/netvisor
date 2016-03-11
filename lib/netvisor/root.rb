require 'happymapper'
require 'netvisor/sales_invoice'

module Netvisor
  class Root
    include HappyMapper

    tag 'root'
    has_one :sales_invoice, SalesInvoice
    has_one :product, Product
  end
end
