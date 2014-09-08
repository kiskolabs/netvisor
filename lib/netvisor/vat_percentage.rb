require 'happymapper'

module Netvisor
  class VatPercentage
    include HappyMapper

    attribute :vatcode, String
    content :percentage, Integer
  end
end
