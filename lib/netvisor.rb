require "netvisor/version"
require "netvisor/base"
require "netvisor/configuration"

module Netvisor
  class << self
    attr_accessor :configuration
  end

  def self.new
    Netvisor::Base.new
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new(:sender => 'Netvisor gem')
  end

  def self.reset
    @configuration = Configuration.new(:sender => 'Netvisor gem')
  end
end
