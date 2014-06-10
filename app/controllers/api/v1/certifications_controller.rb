module Api
  module V1
    class CertificationsController < ApplicationController
      before_action :set_certification, only: [:show, :edit, :update, :destroy]
      respond_to :json
      authorize_actions_for Certifications
      #acts_as_token_authentication_handler
    
      # GET /certifications
      # GET /certifications.json
      def index
        @certifications = Certifications.all
        #respond_to do |format|
        #  format.json { render json: @certifications, status: :ok }
        #end
        #render json: @certifications, status: :ok
        respond_with @certifications
      end
    
      # GET /certifications/1
      # GET /certifications/1.json
      def show
        #render json: @certification
        respond_with @certification
      end
    
      # GET /certifications/new
      def new
        @certification = Certifications.new
      end
    
      # GET /certifications/1/edit
      def edit
      end
    
      # POST /certifications
      # POST /certifications.json
      def create
        @certification = Certifications.new(certification_params)
logger.debug "certification: "+@certification.inspect
    
        if @certification.save
          #respond_with @certification
          render json: @certification
          #format.html { redirect_to @certification, notice: 'Certification was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @certification }
        else
          respond_with @certification.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @certification.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /certifications/1
      # PATCH/PUT /certifications/1.json
      def update
        certification_params.each_pair do |property,value|
          @certification.send(property+'=',value)if @certification.respond_to?(property+'=')
        end
        @certification.updater_id = current_user
        if @certification.save
          set_certification
          #respond_with @certification
          render json: @certification, status: :ok
        else
          ##render json: @certification.errors, status: :unprocessable_entity
          respond_with @certification.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /certifications/1
      # DELETE /certifications/1.json
      def destroy
        @certification.destroy
        respond_to do |format|
          format.html { redirect_to certifications_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_certification
logger.debug "set_certification curr_user: " + current_user.inspect
          begin
            @certification = Certifications.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            logger.error "Attempt to access invalid certification #{params[:id]}"
            @certification_not_found = true
            render json: {message: "Illegal certification access request"}, status: :unauthorized
            return
          else
            @certification_not_found = false
          end
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def certification_params
          params.require(:certification).permit(:name)
        end
    end
  end
end
