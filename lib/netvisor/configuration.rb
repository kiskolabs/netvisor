module Netvisor
  Configuration =  Struct.new(
                              :host,
                              :sender,
                              :customer_id,
                              :partner_id,
                              :language,
                              :organisation_id,
                              :customer_key,
                              :partner_key,
                              :log_level) do

    # Initialize override to accept named parameters (Configuration(:host => 'foo'...))
    # http://stackoverflow.com/questions/5407940/named-parameters-in-ruby-structs
    def initialize *args
      return super unless (args.length == 1 and args.first.instance_of? Hash)
      args.first.each_pair do |k, v|
        self[k] = v if members.map {|x| x.intern}.include? k
      end
    end
  end
end
