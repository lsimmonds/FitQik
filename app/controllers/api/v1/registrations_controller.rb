module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json
      skip_before_filter  :verify_authenticity_token, :only => [ :new, :create, :cancel ]
      skip_before_filter  :authenticate_user_from_token, :only => [ :new, :create, :cancel ]

      def options
        puts "In RegistrationsController options params: "+params.inspect
        render json: {}
      end

      def create
        puts "In RegistrationsController create params: "+sign_up_params.inspect
        super
      end

      def sign_up_params
puts "In sign_up_params params: "+params.inspect
        params.require(:api_user).permit(:name, :email, :password, :password_confirmation)
      end

    end
  end
end
    
