require 'happymapper'
require 'netvisor/country_code'

module Netvisor
  class Customer
    include HappyMapper

    tag self.name.split('::').last

    class BaseInfo
      include HappyMapper
      include ElementBase

      element :netvisor_key, Integer, :tag => 'NetvisorKey'
      element :internal_identifier, String, :tag => 'InternalIdentifier'
      element :external_identifier, String, :tag => 'ExternalIdentifier'
      element :customer_group_netvisor_key, String, :tag => 'CustomerGroupNetvisorKey'
      element :customer_group_name, String, :tag => 'CustomerGroupName'
      element :name, String, :tag => 'Name'
      element :name_extension, String, :tag => 'NameExtension'
      element :street_address, String, :tag => 'StreetAddress'
      element :city, String, :tag => 'City'
      element :post_number, String, :tag => 'PostNumber'
      element :country_code, CountryCode, :tag => 'Country'
      element :phone_number, String, :tag => 'PhoneNumber'
      element :fax_number, String, :tag => 'FaxNumber'
      element :email, String, :tag => 'Email'
      element :home_page_uri, String, :tag => 'HomePageUri'
      element :is_active, Integer, :tag => 'IsActive'
    end

    class FinvoiceDetails
      include HappyMapper
      include ElementBase

      element :address, String, :tag => 'FinvoiceAddress' # E-invoice adress e.g. FI10970021497
      element :router_code, String, :tag => 'FinvoiceRouterCode' # E-invoice operator e.g. NDEAFIHH
    end

    class DeliveryDetails
      include HappyMapper
      include ElementBase

      element :name, String, :tag => 'DeliveryName'
      element :address, String, :tag => 'DeliveryStreetAddress'
      element :city, String, :tag => 'DeliveryCity'
      element :post_number, String, :tag => 'DeliveryPostNumber'
      element :country, CountryCode, :tag => 'DeliveryCountry'
    end

    class ContactDetails
      include HappyMapper
      include ElementBase
      element :name, String, :tag => 'ContactPerson'
      element :email, String, :tag => 'ContactPersonEmail'
      element :phone_number, String, :tag => 'ContactPersonPhone'
    end

    class AdditionalInformation
      include HappyMapper
      include ElementBase

      element :comment, String, :tag => 'Comment'
      element :reference_number, String, :tag => 'ReferenceNumber'
      element :balance_limit, String, :tag => 'BalanceLimit'
      element :discount_percentage, String, :tag => 'DiscountPercentage'
      element :price_group, String, :tag => 'PriceGroup'
      element :sales_person, String, :tag => 'DefaultSalesPerson'
    end

    has_one :base_info, BaseInfo, :tag => 'CustomerBaseInformation'
    has_one :finvoice_details, FinvoiceDetails, :tag => 'CustomerFinvoiceDetails'
    has_one :delivery_details, DeliveryDetails, :tag => 'CustomerDeliveryDetails'
    has_one :contact_details, ContactDetails, :tag => 'CustomerContactDetails'
    has_one :additional_information, AdditionalInformation, :tag => 'CustomerAdditionalInformation'
  end
end
