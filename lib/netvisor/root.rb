require 'happymapper'
require 'netvisor/sales_invoice'
require 'netvisor/sales_payment'
require 'netvisor/purchase_invoice'
require 'netvisor/product'
require 'netvisor/customer'
require 'netvisor/payment'


module Netvisor
  class Root
    include HappyMapper

    tag 'root'
    has_one :sales_invoice, SalesInvoice
    has_one :purchase_invoice, PurchaseInvoice
    has_one :sales_payment, SalesPayment
    has_one :product, Product
    has_one :customer, Customer
    has_one :payment, Payment
  end
end
