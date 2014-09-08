require 'happymapper'
require 'netvisor/sales_invoice_line'
require 'netvisor/vat_percentage'

module Netvisor
  class SalesInvoice
    include HappyMapper

      tag self.name.split('::').last

      class InvoiceDate
        include HappyMapper

        attribute :format, String
        content :date, Date
      end

      class InvoiceDeliveryDate
        include HappyMapper

        attribute :format, String
        content :date, Date
      end

      class InvoiceAmount
        include HappyMapper

        attribute :iso4217currencycode, String
        attribute :currencyrate, Float
        content :amount, Float
      end

      class SellerId
        include HappyMapper

        attribute :type, String
        content :id, String
      end

      class InvoiceStatus
        include HappyMapper

        attribute :type, String
        content :status, String
      end

      class CustomerId
        include HappyMapper

        attribute :type, String
        content :id, String
      end

      class CountryCode
        include HappyMapper

        attribute :type, String
        content :country_code, String
      end

      class CashDiscount
        include HappyMapper

        attribute :type, String
        content :discount, Integer
      end

      class DirectDebitLink
        include HappyMapper

        attribute :mode, String
        content :link, Integer
      end

      class InvoiceVoucherLines
        include HappyMapper

        class VoucherLine
          include HappyMapper

          tag 'VoucherLine'

          class LineSum
            include HappyMapper

            attribute :type, String
            content :sum, Float
          end

          element :line_sum, LineSum, :tag => 'LineSum'
          element :description, String, :tag => 'Description'
          element :account_number, String, :tag => 'AccountNumber'
          element :vat_percentage, VatPercentage, :tag => 'VatPercent'
        end

        has_many :lines, VoucherLine, :tag => 'VoucherLine'
      end


      class SalesInvoiceAttachments
        include HappyMapper

        class InvoiceAttachment
          include HappyMapper

          tag self.name.split('::').last

          element :mime_type, String, :tag => 'MimeType'
          element :description, String, :tag => 'AttachmentDescription'
          element :filename, String, :tag => 'FileName'
          element :document_data, String, :tag => 'DocumentData'
        end

        has_many :attachments, InvoiceAttachment, :tag => 'SalesInvoiceAttachment'
      end


      class CustomTags
        include HappyMapper


        class CustomTag
          include HappyMapper

          class TagValue
            include HappyMapper

            attribute :datatype, String
            content :value, String

          end


          element :name, String, :tag => 'TagName'
          element :value, TagValue, :tag => 'TagValue'
        end

        has_many :tags, CustomTag, :tag => 'Tag'
      end


      class SalesInvoiceLines
        include HappyMapper

        has_many :invoice_lines, SalesInvoiceLine, :tag => 'InvoiceLine'

      end

      element :invoice_number, String, :tag => 'SalesInvoiceNumber'
      element :invoice_date, InvoiceDate, :tag => 'SalesInvoiceDate'
      element :invoice_delivery_date, InvoiceDeliveryDate, :tag => 'SalesInvoiceDeliveryDate'
      element :reference_number, String, :tag => 'SalesInvoiceReferenceNumber'
      element :invoice_amount, InvoiceAmount, :tag => 'SalesInvoiceAmount'
      element :seller_id, SellerId, :tag => 'SellerIdentifier'
      element :seller_name, String, :tag => 'SellerName'
      element :type, String, :tag => 'InvoiceType'
      element :text_before_lines, String, :tag => 'SalesInvoiceFreeTextBeforeLines'
      element :text_after_lines, String, :tag => 'SalesInvoiceFreeTextAfterLines'
      element :our_reference, String, :tag => 'SalesInvoiceOurReference'
      element :your_reference, String, :tag => 'SalesInvoiceYourReference'
      element :comment, String, :tag => 'SalesInvoicePrivateComment'
      element :status, InvoiceStatus, :tag => 'SalesInvoiceStatus'

      element :customer_id, CustomerId, :tag => 'InvoicingCustomerIdentifier'
      element :customer_firstname, String, :tag => 'InvoicingCustomerName'
      element :customer_lastname, String, :tag => 'InvoicingCustomerNameExtension'
      element :customer_address, String, :tag => 'InvoicingCustomerAddressLine'
      element :customer_postal_code, String, :tag => 'InvoicingCustomerPostNumber'
      element :customer_city, String, :tag => 'InvoicingCustomerTown'
      element :customer_country, CountryCode, :tag => 'InvoicingCustomerCountryCode'

      element :delivery_method, String, :tag => 'DeliveryMethod'
      element :delivery_term, String, :tag => 'DeliveryTerm'
      element :delivery_address_name, String, :tag => 'DeliveryAddressName'
      element :delivery_address_name_extension, String, :tag => 'DeliveryAddressNameExtension'
      element :delivery_address_line, String, :tag => 'DeliveryAddressLine'
      element :delivery_address_postal_code, String, :tag => 'DeliveryAddressPostNumber'
      element :delivery_address_city, String, :tag => 'DeliveryAddressTown'
      element :delivery_address_countrey, CountryCode, :tag => 'DeliveryAddressCountryCode'

      element :tax_handling_type, String, :tag => 'SalesInvoiceTaxHandlingType'
      element :payment_net_days, Integer, :tag => 'PaymentTermNetDays'
      element :cash_discount_days, Integer, :tag => 'PaymentTermCashDiscountDays'
      element :cash_discount, CashDiscount, :tag => 'PaymentTermCashDiscount'
      element :partial_payments, Integer, :tag => 'ExpectPartialPayments'
      element :direct_debit_link, DirectDebitLink, :tag => 'TryDirectDebitLink'
      element :overrise_account_number, Integer, :tag => 'OverrideVoucherSalesReceivablesAccountNumber'
      element :subject_type, String, :tag => 'InvoiceSubjectType'

      has_many :invoice_lines, SalesInvoiceLines, :tag => 'InvoiceLines'
      has_many :voucher_lines, InvoiceVoucherLines, :tag => 'InvoiceVoucherLines'
      has_many :attachments, SalesInvoiceAttachments, :tag => 'SalesInvoiceAttachments'
      has_many :custom_tags, CustomTags, :tag => 'CustomTags'
  end
end
