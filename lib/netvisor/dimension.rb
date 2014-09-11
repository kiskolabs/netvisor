require 'happymapper'

class Dimension
  include HappyMapper

  element :name, String, :tag => 'DimensionName'
  element :item, String, :tag => 'DimensionItem'
end
