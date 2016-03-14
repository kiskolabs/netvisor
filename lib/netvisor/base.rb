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

    def request(data_object, service, method = nil, id = nil)
      req = Request.new
      if data_object
        root = Root.new
        root.send("#{service}=", data_object)

        req.dispatch(root.to_xml, service, method, id)
      else
        req.dispatch(nil, service, method, id)
      end
    end

  end
end
