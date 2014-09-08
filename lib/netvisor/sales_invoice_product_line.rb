require 'happymapper'
require 'netvisor/vat_percentage'

module Netvisor
  class SalesInvoiceProductLine
    include HappyMapper

    class ProductId
      include HappyMapper

      attribute :type, String
      content :id, String
    end
    class UnitPrice
      include HappyMapper

      attribute :type, String
      content :price, String
    end

    class Dimension
      include HappyMapper

      element :name, String, :tag => 'DimensionName'
      element :item, String, :tag => 'DimensionItem'
    end

    tag self.name.split('::').last

    element :product_id, ProductId, :tag => 'ProductIdentifier'
    element :name, String, :tag => 'ProductName'
    element :unit_price, UnitPrice, :tag => 'ProductUnitPrice'
    element :vat_percentage, VatPercentage, :tag => 'ProductVatPercentage'
    element :quantity, Integer, :tag => 'SalesInvoiceProductLineQuantity'
    element :accounting_suggestion, Integer, :tag => 'AccountingAccountSuggestion'
    element :AccountingAccountSuggestion, Integer, :tag => 'ProductUnitPurchasePrice'
    element :discount_percentage, Integer, :tag => 'SalesInvoiceProductLineDiscountPercentage'
    has_many :dimensions, Dimension, :tag => 'Dimension'
  end
end
