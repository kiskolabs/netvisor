require 'netvisor/root'
require 'netvisor/request'

module Netvisor
  class Base
    # The 'sales_invoice' is a Netvisor::SalesInvoice object
    def send_invoice(sales_invoice)
      request(sales_invoice, "sales_invoice")
    end

    # The 'product' is a Netvisor::Product object
    def send_product(product)
      request(product, "product", :post, {method: "add"})
    end

    def send_invoice_batch(batch)
      request(batch, "sales_invoice_batch", :post)
    end

    # The 'product' is a Netvisor::Product object
    # the 'id' is the nexudus id of the product
    def update_product(product, id)
      request(customer, "product", :post, {id: id, method: "edit"})
    end

    # The 'customer' is a Netvisor::Customer object
    def send_customer(customer)
      request(customer, "customer", :post, {method: "add"})
    end

    # The 'customer' is a Netvisor::Customer object
    # the 'id' is the nexudus id of the customer
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
