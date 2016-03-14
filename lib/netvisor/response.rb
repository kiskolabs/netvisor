require 'happymapper'
require 'netvisor/customer'

module Netvisor
  class Response
    include HappyMapper

    class ResponseStatus
      include HappyMapper

      tag self.name.split('::').last

      has_many :statuses, String, :tag => 'Status'
      element :timestamp, DateTime, :tag => 'TimeStamp'

    end

    class ResponseProductList
      include HappyMapper

      class Product
        include HappyMapper

        tag self.name.split('::').last

        element :code,          String, :tag => 'ProductCode'
        element :netvisor_key,  String, :tag => 'NetvisorKey'
        element :name,          String, :tag => 'Name'
        element :unit_price,    String, :tag => 'UnitPrice'
        element :uri,           String, :tag => 'Uri'
      end

      tag self.name.split('::').last
      has_many :products, Product, :tag => 'Product'
    end

    tag 'Root'

    element :status,        ResponseStatus
    element :product_list,  ResponseProductList, :tag => 'ProductList'
    element :customer,      Customer, :tag => 'Customer'
  end
end
