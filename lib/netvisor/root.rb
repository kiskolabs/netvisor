require 'happymapper'
require 'netvisor/sales_invoice'
require 'netvisor/product'
require 'netvisor/customer'


module Netvisor
  class Root
    include HappyMapper

    tag 'root'
    has_one :sales_invoice, SalesInvoice
    has_one :product, Product
    has_one :customer, Customer
  end
end
