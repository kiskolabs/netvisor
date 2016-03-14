require 'netvisor/element_base'

class CountryCode
  include ElementBase
  include HappyMapper

  attribute :type, String
  content :country_code, String
end