class Api::V1::PayController < ApplicationController
  #before_action :set_admin, only: [:show, :edit, :update, :destroy]
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  def auth
  end

  def pay
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
      logger.info "Payment[#{@payment.id}]"
      logger.info "Payment: "+@payment.methods.inspect
      logger.info "Payment transactions: "
      @payment.transactions.each do |transaction|
        logger.info "transaction: "+transaction.inspect
      end
      logger.info "Redirect: #{@redirect_url}"
    else
      logger.error @payment.error.inspect
    end

    #respond_with "{ \"msg\": \"made it\" }"
    #@snippet = fetch_url @redirect_url
    #render template: "api/pay/pay.html.erb"
    redirect_to @redirect_url
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

end
