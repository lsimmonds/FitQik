class FqTransaction < ActiveRecord::Base
  include Authority::Abilities
  stampable #Also lets this model be user stamped
  belongs_to :account

  def self.add(transaction_info)
    #Store payer record
    their_account = Account.find_or_create_by name: transaction_info[:pay_processor]
    their_transaction = FqTransaction.new
    their_transaction.occured = transaction_info[:occured]
    their_transaction.processor = transaction_info[:pay_processor]
    their_transaction.amount = -transaction_info[:amount]
    their_transaction.account_id = their_account.id
    their_transaction.external_id = transaction_info[:external_id] if transaction_info[:external_id]
    their_transaction.callback_id = transaction_info[:callback_id] if transaction_info[:callback_id]
    their_transaction.description = transaction_info[:description]
    their_transaction.pay_object = transaction_info[:pay_object]
    return false unless their_transaction.save
    #Store fitqik record
    our_account = Account.find_or_create_by name: "FitQik Sale" do |a|
      a.description = "Sales received through the web site"
    end
    our_transaction = FqTransaction.new
    our_transaction.occured = transaction_info[:occured]
    our_transaction.processor = transaction_info[:pay_processor]
    our_transaction.amount = transaction_info[:amount]
    our_transaction.account_id = our_account.id
    our_transaction.external_id = transaction_info[:external_id] if transaction_info[:external_id]
    our_transaction.callback_id = transaction_info[:callback_id] if transaction_info[:callback_id]
    our_transaction.description = transaction_info[:description]
    our_transaction.pay_object = transaction_info[:pay_object]
    return false unless our_transaction.save
    return true
  end

  def self.verify_by_callback_id(callback_id)
    FqTransaction.where(:callback_id => callback_id).each do |transaction|
      transaction.validated=true
      transaction.save!
    end
  end

  def self.cancel_by_callback_id(callback_id)
    FqTransaction.where(:callback_id => callback_id).each do |transaction|
      transaction.validated=false
      transaction.save!
    end
  end


end
