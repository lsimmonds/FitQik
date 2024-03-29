module TokenAuth
  module ActsAsTokenAuthenticationHandler
    extend ActiveSupport::Concern

    # Please see https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
    # before editing this file, the discussion is very interesting.

    included do
      private :authenticate_user_from_token!
      # This is our new function that comes before Devise's one
      before_filter :authenticate_user_from_token!
      # This is Devise's authentication
      before_filter :authenticate_api_user!
    end

    # For this example, we are simply using token authentication
    # via parameters. However, anyone could use Rails's token
    # authentication features to get the token from a header.
    def authenticate_user_from_token!
      # Set the authentication token params if not already present,
      # see http://stackoverflow.com/questions/11017348/rails-api-authentication-by-headers-token
      if token = params[:token].blank? && request.headers["X-User-Token"]
        params[:token] = token
      end
      if email = params[:email].blank? && request.headers["X-User-Email"]
        params[:email] = email
      end

      email = params[:email].presence
      user = email && User.find_by(email: email)

      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.
      if user && Devise.secure_compare(user.authentication_token, params[:token])
        # Notice we are passing store false, so the user is not
        # actually stored in the session and a token is needed
        # for every request. If you want the token to work as a
        # sign in token, you can simply remove store: false.
        sign_in user, store: false
      end
    end

    module ClassMethods
      def acts_as_token_authentication_handler(options = {})
        include TokenAuth::ActsAsTokenAuthenticationHandler
      end
    end
  end
end
ActionController::Base.send :include, TokenAuth::ActsAsTokenAuthenticationHandler
