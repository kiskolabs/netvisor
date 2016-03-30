require 'netvisor/root'
require 'netvisor/request'

module Netvisor
  class Base
    def send_invoice(sales_invoice)
      request(sales_invoice, 'sales_invoice')
    end

    def send_product(product)
      request(product, 'product')
    end

    def send_customer(customer)
      request(customer, "customer", :post, {method: "add"})
    end

    def update_customer(customer, id)
      request(customer, "customer", :post, {id: id, method: "edit"})
    end

    def get_customers(query = nil)
      # query = { keyword: "ABC123" } Filters result list with given keyword. 
      # Match is searched from following fields: Name, Customer Code, Organization identifier, CoName
      request(nil, "customerlist", :get, query)
    end

    def get_customer(customer_id)
      request(nil, "getcustomer", :get, {id: customer_id})
    end

    def get_products
      request(nil, "productlist", :get)
    end

    def request(data_object, service, http_method = nil, query = nil)
      req = Request.new
      if data_object
        root = Root.new
        root.send("#{service}=", data_object)

        req.dispatch(root.to_xml, service, http_method, query)
      else
        req.dispatch(nil, service, http_method, query)
      end
    end

  end
end
