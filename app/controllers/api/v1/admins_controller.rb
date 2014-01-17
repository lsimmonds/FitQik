module Api
  module V1
    class AdminsController < ApplicationController
      before_action :set_admin, only: [:show, :edit, :update, :destroy]
      respond_to :json
      #acts_as_token_authentication_handler
    
      # GET /admins
      # GET /admins.json
      def index
        @admins = Admin.all
        #respond_to do |format|
        #  format.json { render json: @admins, status: :ok }
        #end
        #render json: @admins, status: :ok
        respond_with @admins
      end
    
      # GET /admins/1
      # GET /admins/1.json
      def show
        #render json: @admin
        respond_with @admin
      end
    
      # GET /admins/new
      def new
        @admin = Admin.new
      end
    
      # GET /admins/1/edit
      def edit
      end
    
      # POST /admins
      # POST /admins.json
      def create
        @admin = Admin.new(admin_params)
        @current_user = User.find_by email: params[:email]
        @admin.user_id = @current_user.id
    
        if @admin.save
          #respond_with @admin
          render json: @admin
          #format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @admin }
        else
          respond_with @admin.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @admin.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /admins/1
      # PATCH/PUT /admins/1.json
      def update
        admin_params.each_pair do |property,value|
          @admin.send(property+'=',value)if @admin.respond_to?(property+'=')
        end
        if @admin.save
          set_admin
          #respond_with @admin
          render json: @admin, status: :ok
        else
          ##render json: @admin.errors, status: :unprocessable_entity
          respond_with @admin.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /admins/1
      # DELETE /admins/1.json
      def destroy
        @admin.destroy
        respond_to do |format|
          format.html { redirect_to admins_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_admin
          @admin = Admin.find(params[:id])
          @current_user = User.find_by email: params[:email]
          render json: {message: "Illegal admin access request"}, status: :unauthorized unless @current_user.id == @admin.user_id
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def admin_params
          params.require(:admin).permit(:name)
        end
    end
  end
end
