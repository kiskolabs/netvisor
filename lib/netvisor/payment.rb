require 'happymapper'
require 'netvisor/element_base'

module Netvisor
  class Payment
    include HappyMapper
    include ElementBase

    tag self.name.split('::').last

    class Recipient
      include HappyMapper
      include ElementBase

      element :name, String
      element :address, String
      element :postcode, String
      element :town, String
    end

    class DestinationBankAccount
      include HappyMapper
      include ElementBase

      element :bank_name, String, :tag => 'bankname'
      element :bank_branch, String, :tag => 'bankbranch'
      element :destination_bank_account_number, String, :tag => 'destinationbankaccountnumber'
    end

    has_one :recipient, Recipient, :tag => 'recipient'
    has_one :destination_bank_account, DestinationBankAccount, :tag => 'destinationbankaccount'

    element :bank_payment_message_type, String, :tag => 'bankpaymentmessagetype'
    element :bank_payment_message, String, :tag => 'bankpaymentmessage'
    element :source_bank_account_number, String, :tag => 'sourcebankaccountnumber',
    element :duedate, Date, :tag => 'duedate'
  end
end
