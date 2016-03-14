require 'happymapper'
require 'netvisor/vat_percentage'
require 'netvisor/unit_price'
require 'netvisor/dimension'
require 'netvisor/element_base'

module Netvisor
  class SalesInvoiceProductLine
    include HappyMapper

    class ProductId
      include ElementBase
      include HappyMapper

      attribute :type, String
      content :id, String
    end

    tag self.name.split('::').last

    element :product_id, ProductId, :tag => 'ProductIdentifier'
    element :name, String, :tag => 'ProductName'
    element :unit_price, UnitPrice, :tag => 'ProductUnitPrice'
    element :unit_purchase_price, UnitPrice, :tag => 'ProductUnitPurchasePrice'
    element :vat_percentage, VatPercentage, :tag => 'ProductVatPercentage'
    element :quantity, Integer, :tag => 'SalesInvoiceProductLineQuantity'
    element :discount_percentage, Integer, :tag => 'SalesInvoiceProductLineDiscountPercentage'
    element :free_text, String, :tag => 'SalesInvoiceProductLineFreeText'
    element :vat_sum, Float, :tag => 'SalesInvoiceProductLineVatSum'
    element :line_sum, Float, :tag => 'SalesInvoiceProductLineSum'
    element :accounting_suggestion, Integer, :tag => 'AccountingAccountSuggestion'
    element :skip_accrual, Integer, :tag => 'SkipAccrual'
    has_many :dimensions, Dimension, :tag => 'Dimension'
  end
end
