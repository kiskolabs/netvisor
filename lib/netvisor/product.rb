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
      element :unitweight, Integer, :tag => 'unitweight'
      element :purchaseprice, Integer, :tag => 'purchaseprice'
      element :tariffheading, String, :tag => 'tariffheading'
      element :comissionpercentage, Integer, :tag => 'comissionpercentage'
      element :is_active, Integer, :tag => 'isactive' # 0=no, 1=yes 
      element :issalesproduct, Integer, :tag => 'issalesproduct' # 0=no, 1=yes
      element :inventoryenabled, Integer, :tag => 'inventoryenabled' # 0=no, 1=yes

      has_one :bookkeeping_details, BookkeepingDetails, :tag => 'productbookkeepingdetails'
    end

    has_one :base_info, BaseInfo, :tag => 'productbaseinformation'
  end
end