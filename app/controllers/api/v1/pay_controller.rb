class Api::V1::PayController < ApplicationController
  #before_action :set_pay, only: [:show, :edit, :update, :destroy]
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  def auth
  end

  def pay_paypal
    # #Create Payment Using PayPal Sample
    # This sample code demonstrates how you can process a
    # PayPal Account based Payment.
    # API used: /v1/payments/payment
    
    # ###Payment
    # A Payment Resource; create one using
    # the above types and intent as 'sale'
    @payment = Payment.new({
      :intent => "sale",
    
      # ###Payer
      # A resource representing a Payer that funds a payment
      # Payment Method as 'paypal'
      :payer => { :payment_method => "paypal" },

      # ###Redirect URLs
      :redirect_urls => {
        :return_url => "http://199.195.192.136/fitqik/paygood.php",
        :cancel_url => "http://199.195.192.136/fitqik/paybad.php" },

      # ###Transaction
      # A transaction defines the contract of a
      # payment - what is the payment for and who
      # is fulfilling it.
      :transactions => [{
    
        # Item List
        :item_list => {
          :items => [{ :name => "item", :sku => "item", :price => "5", :currency => "USD", :quantity => 2 }]
        },
    
        # ###Amount
        # Let's you specify a payment amount.
        :amount => { :total => "10", :currency => "USD" },
        :description => "This is the payment transaction description." }
      ]
    })
    
    # Create Payment and return status
    if @payment.create
      # Redirect the user to given approval url
      @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
      uri = URI.parse(@redirect_url)
      callback_id = nil
      uri.query.split('&').each do |q_part|
        arg=q_part.split '='
        if arg[0] == "token"
          callback_id = arg[1]
        end
      end

      @payment.transactions.each do |trans|
        if trans.success?
          transaction_info = {:occured => @payment.create_time,
                              :pay_processor => "paypal",
                              :pay_method => @payment.payer.payment_method,
                              :amount => trans.amount.total.to_d,
                              :external_id => @payment.id,
                              :callback_id => callback_id,
                              :description => "A web payment made through PayPal",
                              :pay_object => @payment.to_json }
          logger.info "Transaction did not save!: "+trans.inspect unless FqTransaction.add(transaction_info)
        end
      end
    else
      logger.error @payment.error.inspect
    end

    redirect_to @redirect_url
  end

  def verify_paypal
    FqTransaction.verify_by_callback_id(pay_params[:pay_token])
    render json: { :msg => "ok" }, status: :ok
  end

  def cancel_paypal
    FqTransaction.cancel_by_callback_id(pay_params[:pay_token])
    render json: { :msg => "ok" }, status: :ok
  end

private

  def fetch_url(url)
    r = Net::HTTP.get_response( URI.parse( url ) )
    if r.is_a? Net::HTTPSuccess
      r.body
    else
      nil
    end
  end

  def pay_params
    params.permit(:pay_token)
  end

end
