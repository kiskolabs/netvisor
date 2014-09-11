class ElementBase
  def initialize(args = {})
    args.each_pair do |key, val|
      self.send("#{key}=", val) if ElementBase.method_defined? key
    end
  end
end
