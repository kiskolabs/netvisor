require 'happymapper'
require 'netvisor/unit_price'
# require 'netvisor/dimension'
require 'netvisor/element_base'

module Netvisor
  class PurchaseInvoice
    include HappyMapper

    tag self.name.split('::').last.downcase

    class PurchaseInvoiceLines
      include HappyMapper

      class PurchaseInvoiceLine
        include ElementBase
        include HappyMapper

        tag self.name.split('::').last

        class Dimension
          include HappyMapper

          has_many :dimensionname, String, :tag => 'dimensionname'
          has_many :dimensionitem, String, :tag => 'dimensionitem'
        end

        class Linesum
          include ElementBase
          include HappyMapper

          attribute :type, String
          content :amount, Float
        end

        element :productcode, String, :tag => 'productcode'
        element :productname, String, :tag => 'productname'
        element :deliveredamount, Integer, :tag => 'deliveredamount'
        element :unitprice, Float, :tag => 'unitprice'
        element :discountpercentage, Float, :tag => 'discountpercentage'
        element :vatpercent, Integer, :tag => 'vatpercent'
        has_one :linesum, Linesum, :tag => 'linesum'
        has_one :dimension, Dimension, :tag => 'dimension'
      end

      has_many :invoice_lines, PurchaseInvoiceLine, :tag => 'purchaseinvoiceline'
    end

    class PurchaseInvoiceCommentLines
      include HappyMapper

      class PurchaseInvoiceCommentLine
        include ElementBase
        include HappyMapper
        tag self.name.split('::').last
        element :comment, String, :tag => 'comment'
      end

      has_many :lines, PurchaseInvoiceCommentLine, :tag => 'purchaseinvoicecommentline'
    end

    class PurchaseInvoiceAttachments
      include HappyMapper

      class PurchaseInvoiceAttachment
        include ElementBase
        include HappyMapper
        tag self.name.split('::').last

        element :mimetype, String, :tag => 'mimetype'
        element :attachmentdescription, String, :tag => 'attachmentdescription'
        element :filename, String, :tag => 'filename'
        element :documentdata, String, :tag => 'documentdata'
      end

      has_many :attachments, PurchaseInvoiceAttachment, :tag => 'purchaseinvoiceattachment'
    end

    element :invoicenumber, String, :tag => 'invoicenumber'
    element :invoicedate, Date, :tag => 'invoicedate'
    element :invoicesource, String, :tag => 'invoicesource'
    element :duedate, String, :tag => 'duedate'
    element :purchaseinvoiceonround, String, :tag => 'purchaseinvoiceonround'
    element :vendorname, String, :tag => 'vendorname'
    element :amount, Float, :tag => 'amount'
    element :bankreferencenumber, String, :tag => 'bankreferencenumber'
    element :ourreference, String, :tag => 'ourreference'
    element :yourreference, String, :tag => 'yourreference'
    element :comment, String, :tag => 'comment'
    element :readyforaccounting, Integer, :tag => 'readyforaccounting'

    has_many :invoice_lines, PurchaseInvoiceLines, :tag => 'purchaseinvoicelines'
    has_many :comments, PurchaseInvoiceCommentLines, :tag => 'purchaseinvoicecommentlines'
    has_many :attachments, PurchaseInvoiceAttachments, :tag => 'purchaseinvoiceattachments'
  end
end
