require 'logging'
require "netvisor/version"
require "netvisor/base"
require "netvisor/configuration"

module Netvisor
  class << self
    attr_accessor :configuration, :logger
  end

  def self.new
    Netvisor::Base.new
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    init_config if (Thread.current[:netvisor_configuration].nil? || Thread.current[:netvisor_configuration] == 1)
    Thread.current[:netvisor_configuration]
  end

  def self.reset
    init_config
    init_logger
  end

  def self.init_logger
    @logger = Logging.logger(STDOUT)
    @logger.level = configuration.log_level
  end

  def self.init_config
    Thread.current[:netvisor_configuration] = Configuration.new(:sender => 'Netvisor gem', :log_level => :debug)
  end

  def self.logger
    init_logger if (@logger.nil? || @logger == 1)
    @logger
  end
end
