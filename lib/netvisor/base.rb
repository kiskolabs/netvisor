require 'netvisor/root'
require 'netvisor/request'

module Netvisor
  class Base
    def send_invoice(sales_invoice)
      request(sales_invoice, 'sales_invoice')
    end

    def send_product(product)
      request(product, 'product', :post,)
    end

    def send_customer(customer)
      request(customer, "customer", :post, "Add")
    end

    def get_customer(customer_id)
      request(nil, "getcustomer", :get, customer_id)
    end

    def get_products
      request(nil, "productlist", :get, nil)
    end

    def request(data_object, service, http_method = nil, method = nil, id = nil)
      req = Request.new
      if data_object
        root = Root.new
        root.send("#{service}=", data_object)

        req.dispatch(root.to_xml, service, http_method, method, id)
      else
        req.dispatch(nil, service, http_method, method, id)
      end
    end

  end
end
