require 'net/http'
require 'uri'
require 'openssl'
require 'netvisor/response'

module Netvisor
  class Request

    def dispatch(xml, service, http_method = nil, query = nil)
      http_method ||= :post
      query ||= {}
      url = self.class.build_url(service, query)
      headers = self.class.build_headers(url)

      xml.gsub!("<?xml version=\"1.0\"?>", '') if xml

      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      http.set_debug_output($stdout) if ENV['DEBUG_NETVISOR_RESPONSE']

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
        raise "Can't connect to Netvisor. Response: #{response.inspect}, Body: #{response.body}"
      end

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
      timestamp_unix = Time.now.utc.to_i.to_s
      transaction_id = DateTime.current.strftime('%Q')
      return {
        'X-Netvisor-Authentication-Sender' => Netvisor.configuration.sender,
        'X-Netvisor-Authentication-CustomerId' => Netvisor.configuration.customer_id,
        'X-Netvisor-Authentication-PartnerId' => Netvisor.configuration.partner_id,
        'X-Netvisor-Authentication-TimestampUnix' => timestamp_unix,
        'X-Netvisor-Authentication-Timestamp' => timestamp,
        'X-Netvisor-Authentication-TransactionId' => transaction_id,
        'X-Netvisor-Interface-Language' => Netvisor.configuration.language,
        'X-Netvisor-Organisation-ID' => Netvisor.configuration.organisation_id,
        'X-Netvisor-Authentication-MAC' => build_mac(url, timestamp, transaction_id, timestamp_unix),
        'X-Netvisor-Authentication-MACHashCalculationAlgorithm' => 'HMACSHA256',
        'X-Netvisor-Authentication-UseHTTPResponseStatusCodes' => '1'
      }
    end

    def self.build_mac(url, timestamp, transaction_id, timestamp_unix)
      data = [
        url,
        Netvisor.configuration.sender,
        Netvisor.configuration.customer_id,
        timestamp,
        Netvisor.configuration.language,
        Netvisor.configuration.organisation_id,
        transaction_id,
        timestamp_unix,
        Netvisor.configuration.customer_key,
        Netvisor.configuration.partner_key
      ].join('&')

      # Use HMACSHA256 with both customer_key and partner_key as the secret
      # Reference: https://support.netvisor.fi/en/support/solutions/articles/77000557880-api-authentication#HMACSHA256-authentication
      hmac_key = [
        Netvisor.configuration.customer_key,
        Netvisor.configuration.partner_key
      ].join('&')
      Netvisor.logger.debug "build_mac data: #{data}"
      Netvisor.logger.debug "build_mac key: #{hmac_key}"
      OpenSSL::HMAC.hexdigest('SHA256', hmac_key, data)
    end
  end
end
