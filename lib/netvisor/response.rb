require 'happymapper'
require 'netvisor/customer'
require 'netvisor/sales_invoice_line'

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

    class SalesInvoice
      include HappyMapper

      class SalesInvoiceLines
        include HappyMapper
        has_many :invoice_lines, SalesInvoiceLine, :tag => 'InvoiceLine'
      end

      element :sales_invoice_number, String, :tag => 'SalesInvoiceNumber'
      element :sales_invoice_date, String, :tag => 'SalesInvoiceDate'
      element :sales_invoice_amount, Float, :tag => 'SalesInvoiceAmount'
      element :invoice_status, String, :tag => 'InvoiceStatus'
      element :invoicing_customer_name, String, :tag => 'InvoicingCustomerName'
      element :invoicing_customer_netvisor_key, String, :tag => 'InvoicingCustomerNetvisorKey'
      element :invoice_lines, SalesInvoiceLines, :tag => 'InvoiceLines'
    end

    class SalesInvoiceList
      include HappyMapper

      class SalesInvoice
        include HappyMapper

        tag self.name.split('::').last

        element :netvisor_key, String, :tag => 'NetvisorKey'
        element :sales_invoice_number, String, :tag => 'InvoiceNumber'
        element :sales_invoice_date, Date, :tag => 'Invoicedate'
        element :sales_invoice_status, String, :tag => 'InvoiceStatus'
        element :customer_code, String, :tag => 'CustomerCode'
        element :customer_name, String, :tag => 'CustomerName'
        element :reference_number, String, :tag => 'ReferenceNumber'
        element :invoice_sum, Float, :tag => 'InvoiceSum'
        element :open_sum, Float, :tag => 'OpenSum'
        element :uri, String, :tag => 'Uri'
      end

      has_many :sales_invoices, SalesInvoice, :tag => 'SalesInvoice'
    end

    tag 'Root'

    element :replies,            Replies
    element :status,             ResponseStatus
    element :product_list,       ResponseProductList, :tag => 'ProductList'
    element :customer,           Customer, :tag => 'Customer'
    element :customer_list,      ResponseCustomerList, :tag => 'Customerlist'
    element :sales_invoice,      SalesInvoice, :tag => 'SalesInvoice'
    element :sales_invoice_list, SalesInvoiceList, :tag => 'SalesInvoiceList'
  end
end
