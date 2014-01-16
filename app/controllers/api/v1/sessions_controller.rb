module Api
  module V1
    class SessionsController < Devise::SessionsController
      include Devise::Controllers::Helpers
      skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
      prepend_before_filter :require_no_authentication, :only => [:create ]
      acts_as_token_authentication_handler
       
      respond_to :json
       
      def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        resource.save!
        @resource = resource
        render json: {
          token: resource.authentication_token,
          email: resource.email
        }
      end
       
      def destroy
        sign_out(resource_name)
      end

      def sign_in_params
        params.require(:api_user).permit(:email, :password)
      end
       
    end
  end
end