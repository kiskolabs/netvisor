require 'netvisor/element_base'
require 'happymapper'

module Netvisor
  class CountryCode
    include ElementBase
    include HappyMapper

    attribute :type, String
    content :country_code, String
  end
end