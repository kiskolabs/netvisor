require 'faraday'
require 'config'

module Netvisor
  class Request

    def initialize(config)
      @config = config || Config.new
    end

    def send(xml, service, method = nil, id = nil)
      url = build_url(service, method, id)
      headers = build_headers(url)
      root = Netvisor::Root.parse(File.read("example_salesinvoice.xml"))
      xml = root.to_xml
      p xml

      new_xml = "<!DOCTYPE salesinvoice SYSTEM \"salesinvoice.dtd\" >" + xml
      # tell the parsing to actually load the DTD which it doesn't do by default
      # options = Nokogiri::XML::ParseOptions::DEFAULT_XML | Nokogiri::XML::ParseOptions::DTDLOAD
      doc = Nokogiri::XML::Document.parse(new_xml)#,nil,nil,options)
      xml.gsub!("<?xml version=\"1.0\"?>", '')
      p xml

      res = Faraday.post(url) do |req|
        req.headers.merge!(headers)
        req.body = xml
      end
      p res
    end

    def build_url(service, method, id)
      url = "#{@config.host || 'http://integrationdemo.netvisor.fi'}/#{service.gsub(/_/,'')}.nv"
    end

    def build_headers(url)
      timestamp = DateTime.parse(Time.now.utc.to_s).strftime("%F %T.%L")
      transaction_id = ((1000...9999).to_a.choice + Time.now.to_i).to_s
      return {
        'X-Netvisor-Authentication-Sender' => @config.sender || 'Netvisor gem',
        'X-Netvisor-Authentication-CustomerId' => @config.customer_id || 'EB_10197_551',
        'X-Netvisor-Authentication-PartnerId' => @config.partner_id || 'Efi_249',
        'X-Netvisor-Authentication-Timestamp' => timestamp,
        'X-Netvisor-Authentication-MAC' => build_mac(url, timestamp, transaction_id),
        'X-Netvisor-Authentication-TransactionId' => transaction_id,
        'X-Netvisor-Interface-Language' => @config.language || 'FI',
        'X-Netvisor-Organisation-ID' => @config.organisation_id || '0111111-7',
        'X-Netvisor-Authentication-MACHashCalculationAlgorithm' => 'SHA256'
      }
    end

    def build_mac(url, timestamp, transaction_id)
      arr = [
        url,
        @config.sender || 'Netvisor gem',
        @config.customer_id || 'EB_10197_551',
        timestamp,
        @config.language || 'FI',
        @config.organisation_id || '0111111-7',
        transaction_id,
        @config.customer_key || 'EF1E64BD5D7E0301417B7FE1BF059694',
        @config.partner_key || '6F4C9C0DD3C1C263DAC131ED3AF89A7C'
      ]
      p timestamp, arr.join('&')
      Digest::SHA2.hexdigest(arr.join('&'))
    end
  end
end
