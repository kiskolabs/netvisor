require 'happymapper'
require 'netvisor/vat_percentage'
require 'netvisor/unit_price'
require 'netvisor/element_base'

module Netvisor
  class Product
    include HappyMapper

    tag self.name.split('::').last

    class BookkeepingDetails
      include HappyMapper
      include ElementBase

      element :vat_percentage, VatPercentage, :tag => 'defaultvatpercentage'
    end

    class BaseInfo
      include HappyMapper

      element :code, String, :tag => 'productcode'
      element :group, String, :tag => 'productgroup'
      element :name, String, :tag => 'name'
      element :description, String, :tag => 'description'
      element :unit_price, UnitPrice, :tag => 'unitprice'
      element :unit, String, :tag => 'unit'
      element :unit_weight, Integer, :tag => 'unitweight'
      element :purchase_price, Integer, :tag => 'purchaseprice'
      element :tariff_heading, String, :tag => 'tariffheading'
      element :comission_percentage, Integer, :tag => 'comissionpercentage'
      element :is_active, Integer, :tag => 'isactive' # 0=no, 1=yes 
      element :is_sales_product, Integer, :tag => 'issalesproduct' # 0=no, 1=yes
      element :inventory_enabled, Integer, :tag => 'inventoryenabled' # 0=no, 1=yes

      has_one :bookkeeping_details, BookkeepingDetails, :tag => 'productbookkeepingdetails'
    end

    has_one :base_info, BaseInfo, :tag => 'productbaseinformation'
  end
end