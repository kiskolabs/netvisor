require 'happymapper'

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

    class VatPercentage
      include HappyMapper

      attribute :vatcode, String
      content :percentage, Integer
    end

    tag self.name.split('::').last

    has_one :product_id, ProductId, :tag => 'ProductIdentifier'
    has_one :name, String, :tag => 'ProductName'
    has_one :unit_price, UnitPrice, :tag => 'ProductUnitPrice'
    has_one :vat_percentage, VatPercentage, :tag => 'ProductVatPercentage'
    has_one :quantity, Integer, :tag => 'SalesInvoiceProductlineQuantity'
    has_one :AccountingAccountSuggestion, Integer, :tag => 'AccountingAccountSuggestion'
  end
end
