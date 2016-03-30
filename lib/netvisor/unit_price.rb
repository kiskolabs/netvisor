require 'happymapper'
require 'netvisor/element_base'

module Netvisor
  class UnitPrice
    include ElementBase
    include HappyMapper

    attribute :type, String # net or gross
    content :price, Float
  end
end