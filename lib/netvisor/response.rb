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

    class Replies
      include HappyMapper

      tag self.name.split('::').last
      element :inserted_data_identifier, Integer, :tag => 'InsertedDataIdentifier'
    end

    class ResponseCustomerList
      include HappyMapper

      class Customer
        include HappyMapper

        tag self.name.split('::').last

        element :netvisor_key,            Integer, :tag => 'Netvisorkey'
        element :name,                    String, :tag => 'Name'
        element :code,                    String, :tag => 'Code'
        element :organisation_identifier, String, :tag => 'OrganisationIdentifier'
        element :uri,                     String, :tag => 'Uri'
      end

      has_many :customers, Customer
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

      has_many :products, Product, :tag => 'Product'
    end

    tag 'Root'

    element :replies,       Replies
    element :status,        ResponseStatus
    element :product_list,  ResponseProductList, :tag => 'ProductList'
    element :customer,      Customer, :tag => 'Customer'
    element :customer_list, ResponseCustomerList, :tag => 'Customerlist'
  end
end
