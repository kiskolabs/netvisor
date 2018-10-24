require 'happymapper'
require 'netvisor/sales_invoice_line'
require 'netvisor/vat_percentage'
require 'netvisor/country_code'
require 'netvisor/dimension'
require 'netvisor/element_base'

module Netvisor
  class SalesPayment
    include HappyMapper
    include ElementBase

      tag self.name.split('::').last

      class TargetIdentifier
        include HappyMapper
        include ElementBase

        attribute :type, String
        attribute :targettype, String
        content :identifier, Date
      end

      class Sum
        include HappyMapper
        include ElementBase

        attribute :currency, String
        content :amount, Float
      end

      class PaymentMethod
        include HappyMapper
        include ElementBase

        attribute :type, String
        content :method, Float
      end

      element :sum, Sum, :tag => 'sum'
      element :payment_date, String, :tag => 'paymentdate'
      element :target_identifier, TargetIdentifier, :tag => 'targetidentifier'
      element :source_name, String, :tag => 'sourcename'
      element :payment_method, PaymentMethod, :tag => 'paymentmethod'
  end
end
