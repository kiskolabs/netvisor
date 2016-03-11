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
      root = Root.new
      root.send("#{service}=", data_object)
      # validate root
      req = Request.new

      req.dispatch(root.to_xml, service, method, id)
    end

  end
end
