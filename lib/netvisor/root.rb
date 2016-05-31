require 'happymapper'
require 'netvisor/sales_invoice'
require 'netvisor/product'
require 'netvisor/customer'
require 'netvisor/sales_invoice_batch'

module Netvisor
  class Root
    include HappyMapper

    tag 'root'
    has_one :sales_invoice, SalesInvoice
    has_one :product, Product
    has_one :customer, Customer
    has_one :sales_invoice_batch, SalesInvoiceBatch
  end
end
