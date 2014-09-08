require 'netvisor/root'
require 'netvisor/request'

module Netvisor
  class Base
    def initialize(config)
      @config = config
    end

    def send_invoice(sales_invoice)
      request(sales_invoice, 'sales_invoice')
    end

    def request(data_object, service, method = nil, id = nil)
      root = Root.new
      # root.send(service, data_object)
      # validate root
      req = Request.new(@config)

      req.send(root.to_xml, service, method, id)
    end

  end
end
