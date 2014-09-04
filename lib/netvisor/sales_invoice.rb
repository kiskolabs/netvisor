require 'happymapper'
require 'netvisor/sales_invoice_line'

module Netvisor
  class SalesInvoice
    include HappyMapper

      tag self.name.split('::').last

      class InvoiceDate
        include HappyMapper

        attribute :format, String
        content :date, Date
      end

      class InvoiceStatus
        include HappyMapper

        attribute :type, String
        content :status, String
      end

      class CustomerId
        include HappyMapper

        attribute :type, String
        content :id, String
      end

      has_one :invoice_date, InvoiceDate, :tag => 'SalesInvoiceDate'
      has_one :invoice_amount, Integer, :tag => 'SalesInvoiceAmount'
      has_one :type, String, :tag => 'InvoiceType'
      has_one :status, InvoiceStatus, :tag => 'SalesInvoiceStatus'
      has_one :customer_id, CustomerId, :tag => 'InvoicingCustomerIdentifier'
      has_one :customer_firstname, String, :tag => 'InvoicingCustomerName'
      has_one :customer_lastname, String, :tag => 'InvoicingCustomerNameExtension'
      has_one :customer_address, String, :tag => 'InvoicingCustomerAddressLine'
      has_one :customer_postal_code, String, :tag => 'InvoicingCustomerPostNumber'
      has_one :customer_city, String, :tag => 'InvoicingCustomerTown'
      has_one :payment_net_days, Integer, :tag => 'PaymentTermNetDays'
      has_one :partial_payments, Integer, :tag => 'ExpectPartialPayments'

      has_many :invoice_lines, SalesInvoiceLine, :tag => 'InvoiceLines'
  end
end
