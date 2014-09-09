require 'faraday'

module Netvisor
  class Request

    def send(xml, service, method = nil, id = nil)
      url = self.class.build_url(service, method, id)
      headers = self.class.build_headers(url)
      xml.gsub!("<?xml version=\"1.0\"?>", '')

      res = Faraday.post(url) do |req|
        req.headers.merge!(headers)
        req.body = xml
      end
      p res
    end

    def self.build_url(service, method, id)
      url = "#{Netvisor.configuration.host || 'http://integrationdemo.netvisor.fi'}/#{service.gsub(/_/,'')}.nv"
    end

    def self.build_headers(url)
      timestamp = DateTime.parse(Time.now.utc.to_s).strftime("%F %T.%L")
      transaction_id = ((1000...9999).to_a.choice + Time.now.to_i).to_s
      return {
        'X-Netvisor-Authentication-Sender' => Netvisor.configuration.sender || 'Netvisor gem',
        'X-Netvisor-Authentication-CustomerId' => Netvisor.configuration.customer_id || 'EB_10197_551',
        'X-Netvisor-Authentication-PartnerId' => Netvisor.configuration.partner_id || 'Efi_249',
        'X-Netvisor-Authentication-Timestamp' => timestamp,
        'X-Netvisor-Authentication-MAC' => build_mac(url, timestamp, transaction_id),
        'X-Netvisor-Authentication-TransactionId' => transaction_id,
        'X-Netvisor-Interface-Language' => Netvisor.configuration.language || 'FI',
        'X-Netvisor-Organisation-ID' => Netvisor.configuration.organisation_id || '0111111-7',
        'X-Netvisor-Authentication-MACHashCalculationAlgorithm' => 'SHA256'
      }
    end

    def self.build_mac(url, timestamp, transaction_id)
      arr = [
        url,
        Netvisor.configuration.sender || 'Netvisor gem',
        Netvisor.configuration.customer_id || 'EB_10197_551',
        timestamp,
        Netvisor.configuration.language || 'FI',
        Netvisor.configuration.organisation_id || '0111111-7',
        transaction_id,
        Netvisor.configuration.customer_key || 'EF1E64BD5D7E0301417B7FE1BF059694',
        Netvisor.configuration.partner_key || '6F4C9C0DD3C1C263DAC131ED3AF89A7C'
      ]
      p arr.join('&')
      Digest::SHA2.hexdigest(arr.join('&'))
    end
  end
end
