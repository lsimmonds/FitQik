module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json
      skip_before_filter  :verify_authenticity_token, :only => [ :new, :create, :cancel ]
    end
  end
end
    
