module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json
      skip_before_filter  :verify_authenticity_token, :only => [ :new, :create, :cancel ]
      skip_before_filter  :authenticate_user_from_token, :only => [ :new, :create, :cancel ]

      def sign_up_params
        params.require(:api_user).permit(:email, :password, :password_confirmation)
      end

    end
  end
end
    
