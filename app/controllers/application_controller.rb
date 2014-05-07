class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  # This is our new function that comes before Devise's one
#  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  #before_filter :authenticate_user!
  before_filter :current_user, :cors_preflight_check
  after_filter :cors_set_access_control_headers

  @resource

    
  #private
#
#  def authenticate_user_from_token!
#    email = params[:email].presence
#    user = email && User.find_by_email(email)
#
#    # Notice how we use Devise.secure_compare to compare the token
#    # in the database with the token given in the params, mitigating
#    # timing attacks.
#    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
#      sign_in user, store: false
#    end
#  end

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
puts "cors_set_access_control_headers params: "+params.inspect
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
puts "cors_preflight_check params: "+params.inspect
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  private
  # get the user currently logged in
  def current_user
    @current_user ||= User.find_by_email(params[:email]) if params[:email]
  end
  helper_method :current_user

end
