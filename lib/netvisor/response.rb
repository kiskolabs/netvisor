require 'happymapper'

module Netvisor
  class Response
    include HappyMapper

    class ResponseStatus
      include HappyMapper

      tag self.name.split('::').last

      has_many :statuses, String, :tag => 'Status'
      element :timestamp, DateTime, :tag => 'TimeStamp'

    end

    tag 'Root'

    element :status, ResponseStatus

  end
end
