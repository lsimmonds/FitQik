class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  # This is our new function that comes before Devise's one
  #before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  #before_filter :authenticate_user!

  @resource

    
  #private

  #def authenticate_user_from_token!
    #email = params[:email].presence
    #user = email && User.find_by_email(email)
     #
    ## Notice how we use Devise.secure_compare to compare the token
    ## in the database with the token given in the params, mitigating
    ## timing attacks.
    #if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      #sign_in user, store: false
    #end
  #end
end
