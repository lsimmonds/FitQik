module Api
  module V1
    class SessionsController < Devise::SessionsController
      include Devise::Controllers::Helpers
      skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
      prepend_before_filter :require_no_authentication, :only => [:create ]
      acts_as_token_authentication_handler
       
      respond_to :json
       
      def options
        puts "In SessionsController options params: "+params.inspect
        render json: params
      end

      def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        resource.save!
        @resource = resource
	user = User.find_by_email(resource.email)
	   #<User id: 11, email: "test5@leonsimmonds.com", encrypted_password: "$2a$10$nzXDrMguDLutCrpExwcJ3uHoxYhookr9gn.NTt7n7eeM...", name: "who dat", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 8, current_sign_in_at: "2014-07-21 07:15:56", last_sign_in_at: "2014-07-21 07:15:56", current_sign_in_ip: "76.90.34.102", last_sign_in_ip: "76.90.34.102", created_at: "2014-05-06 05:44:57", updated_at: "2014-07-21 07:15:56", authentication_token: "A7uM3kr-vMdVHHgFswEn"> 
	ret_user= {};
	ret_user["token"] = resource.authentication_token
	ret_user["email"] = resource.email
	ret_user["name"] = resource.name
	if !user.teacher.nil?
	  ret_user["teacher"] = user.teacher.attributes
	  ret_user["teacher"]["specialties"] = user.teacher.specialties
	  ret_user["teacher"]["certifications"] = user.teacher.certifications
	  ret_user["teacher"]["skills"] = user.teacher.skills
	end
	if !user.student.nil?
	  ret_user["student"] = user.student
	end
logger.debug "Checking admin role user.has_role?(:admin): "+user.has_role?(:admin).inspect
	if user.has_role?(:admin)
	  ret_user["is_admin"] = true
	end
logger.debug "looking at resource: "+resource.inspect
        #render json: {
        #  token: resource.authentication_token,
        #  email: resource.email,
        #  name: resource.name
        #}
        render json: ret_user
      end
       
      def destroy
        sign_out(resource_name)
        render json: {
        }
      end

      def sign_in_params
        params.require(:api_user).permit(:email, :password)
      end
       
    end
  end
end
