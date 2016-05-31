require 'happymapper'
require 'netvisor/element_base'
require 'netvisor/sales_invoice'

module Netvisor
  class SalesInvoiceBatch
    include HappyMapper

    tag self.name.split('::').last

    class SharedAttachments
      include HappyMapper
      include ElementBase

      class Attachment
        include HappyMapper
        include ElementBase

        class AttachmentData
          include ElementBase
          include HappyMapper

          attribute :type, String # finvoice or pdf
          content :data, Integer # Base64 encoded data of the attachment
        end

        element :mimetype, String, :tag => 'mimetype'
        element :data, AttachmentData, :tag => 'data'
        element :filename, String
        element :description, String
        element :printbydefault, Integer # NOTE! Is not given if the attachment type is Finvoice (otherwise the request is rejected) 1= true, 0=false
        element :itemlink, String
        element :itemidentifier, String

      end

      has_many :attachments, Attachment, :tag => 'attachment'
    end

    class InvoiceItems
      include ElementBase
      include HappyMapper

      class Invoice
        include ElementBase
        include HappyMapper

        element :identifier, String
        element :itemdata, SalesInvoice # 	valid SalesInvoice XML
      end

      has_many :invoices, Invoice, :tag => 'item'
    end

    element :shared_attachments, SharedAttachments, :tag => 'sharedattachments'
    element :items, InvoiceItems, :tag => 'items'
  end
end
