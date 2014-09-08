require "netvisor/version"
require "netvisor/base"

module Netvisor
  def self.new(config)
    Netvisor::Base.new(config)
  end
end
