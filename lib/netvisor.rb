require "netvisor/version"
require "netvisor/base"
require "netvisor/configuration"

module Netvisor
  class << self
    attr_accessor :configuration
  end

  def self.new(config)
    Netvisor::Base.new(config)
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end
end
