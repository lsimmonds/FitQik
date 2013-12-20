module Api
  module V1
    class SessionsController < Devise::SessionsController
      include Devise::Controllers::Helpers
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
       
    end
  end
end
