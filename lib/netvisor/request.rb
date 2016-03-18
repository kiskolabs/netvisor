require 'faraday'
require 'netvisor/response'

module Netvisor
  class Request

    def dispatch(xml, service, http_method = nil, method = nil, id = nil)
      http_method ||= :post
      url = self.class.build_url(service, method, id)
      headers = self.class.build_headers(url)

      Netvisor.logger.debug "dispatch: URL #{url}"
      Netvisor.logger.debug "dispatch: Headers #{headers}"
      xml.gsub!("<?xml version=\"1.0\"?>", '') if xml
      res = Faraday.send(http_method, url) do |req|
        req.headers.merge!(headers)
        req.body = xml if xml
      end

      Netvisor::Response.parse(res.body)
    end

    def self.build_url(service, method, id)
      url = "#{Netvisor.configuration.host}/#{service.gsub(/_/,'')}.nv"
      query_hash = { id: id, method: method }.reject { |k,v| v.nil? }
      if query_hash.any?
        query = CGI.unescape(URI.encode_www_form(query_hash))
        url << "?#{query}"
      end
      url
    end

    def self.build_headers(url)
      timestamp = DateTime.parse(Time.now.utc.to_s).strftime("%F %T.%L")
      transaction_id = ((1000...9999).to_a.shuffle.first + Time.now.to_i).to_s
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
