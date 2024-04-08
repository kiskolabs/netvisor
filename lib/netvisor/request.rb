require 'net/http'
require 'uri'
require 'netvisor/response'

module Netvisor
  class Request

    def dispatch(xml, service, http_method = nil, query = nil)
      http_method ||= :post
      query ||= {}
      url = self.class.build_url(service, query)
      headers = self.class.build_headers(url)

      request_id = headers['X-Netvisor-Authentication-TransactionId']

      Netvisor.logger.debug "[#{request_id}] dispatch: URL #{url}"
      Netvisor.logger.debug "[#{request_id}] dispatch: Headers #{headers}"
      xml.gsub!("<?xml version=\"1.0\"?>", '') if xml

      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      request = case http_method.to_s.downcase
                when 'get'
                  Net::HTTP::Get.new(uri.request_uri)
                when 'post'
                  Net::HTTP::Post.new(uri.request_uri)
                when 'put'
                  Net::HTTP::Put.new(uri.request_uri)
                when 'delete'
                  Net::HTTP::Delete.new(uri.request_uri)
                else
                  raise ArgumentError, "Unsupported HTTP method: #{http_method}"
                end

      headers.each do |key, value|
        request[key] = value
      end

      request.body = xml if xml

      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        raise "Can't connect to Netvisor. Response: #{response.inspect}"
      end

      Netvisor.logger.debug("[#{request_id}] dispatch: Response #{response.body.inspect} Status: #{response.code.inspect}") if ENV['DEBUG_NETVISOR_RESPONSE']

      Netvisor::Response.parse(response.body)
    end

    def self.build_url(service, query)
      url = "#{Netvisor.configuration.host}/#{service.gsub(/_/,'')}.nv"
      if query.any?
        url << "?#{CGI.unescape(URI.encode_www_form(query))}"
      end
      url
    end

    def self.build_headers(url)
      timestamp = DateTime.parse(Time.now.utc.to_s).strftime("%F %T.%L")
      transaction_id = DateTime.current.strftime('%Q')
      return {
        'X-Netvisor-Authentication-Sender' => Netvisor.configuration.sender,
        'X-Netvisor-Authentication-CustomerId' => Netvisor.configuration.customer_id,
        'X-Netvisor-Authentication-PartnerId' => Netvisor.configuration.partner_id,
        'X-Netvisor-Authentication-Timestamp' => timestamp,
        'X-Netvisor-Authentication-MAC' => build_mac(url, timestamp, transaction_id),
        'X-Netvisor-Authentication-TransactionId' => transaction_id,
        'X-Netvisor-Interface-Language' => Netvisor.configuration.language,
        'X-Netvisor-Organisation-ID' => Netvisor.configuration.organisation_id,
        'X-Netvisor-Authentication-MACHashCalculationAlgorithm' => 'SHA256'
      }
    end

    def self.build_mac(url, timestamp, transaction_id)
      arr = [
        url,
        Netvisor.configuration.sender,
        Netvisor.configuration.customer_id,
        timestamp,
        Netvisor.configuration.language,
        Netvisor.configuration.organisation_id,
        transaction_id,
        Netvisor.configuration.customer_key,
        Netvisor.configuration.partner_key
      ]
      Netvisor.logger.debug "build_mac: #{arr.join('&')}"
      Digest::SHA2.hexdigest(arr.join('&'))
    end
  end
end
