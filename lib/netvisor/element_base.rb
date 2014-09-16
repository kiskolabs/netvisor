module ElementBase
  def self.included(base)
    base.class_exec do
      def initialize(args = {})
        args.each_pair do |key, val|
          self.send("#{key}=", val) if ElementBase.method_defined? key
        end
      end
    end
  end
end
