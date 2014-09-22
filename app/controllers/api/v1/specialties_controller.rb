module Api
  module V1
    class SpecialtiesController < ApplicationController
      before_action :set_specialty, only: [:show, :edit, :update, :destroy]
      respond_to :json
      authorize_actions_for Specialty
      #acts_as_token_authentication_handler
    
      # GET /specialties
      # GET /specialties.json
      def index
        #@specialties = Specialty.all(:select => 'id, name').to_a
        @specialties = Specialty.all
        #respond_to do |format|
        #  format.json { render json: @specialties, status: :ok }
        #end
        #render json: @specialties, status: :ok
        respond_with @specialties, :except=>  [:updated_at, :created_at]
      end
    
      # GET /specialties/1
      # GET /specialties/1.json
      def show
        #render json: @specialty
        respond_with @specialty
      end
    
      # GET /specialties/new
      def new
        @specialty = Specialty.new
      end
    
      # GET /specialties/1/edit
      def edit
      end
    
      # POST /specialties
      # POST /specialties.json
      def create
        @specialty = Specialty.new(specialty_params)
logger.debug "specialty: "+@specialty.inspect
    
        if @specialty.save
          #respond_with @specialty
          render json: @specialty, :except=>  [:updated_at, :created_at]
          #format.html { redirect_to @specialty, notice: 'Specialty was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @specialty }
        else
          respond_with @specialty.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @specialty.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /specialties/1
      # PATCH/PUT /specialties/1.json
      def update
        specialty_params.each_pair do |property,value|
          @specialty.send(property+'=',value)if @specialty.respond_to?(property+'=')
        end
        @specialty.updater_id = current_user
        if @specialty.save
          set_specialty
          #respond_with @specialty
          render json: @specialty, :except=>  [:updated_at, :created_at], status: :ok
        else
          ##render json: @specialty.errors, status: :unprocessable_entity
          respond_with @specialty.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /specialties/1
      # DELETE /specialties/1.json
      def destroy
        @specialty.destroy
        respond_to do |format|
          format.html { redirect_to specialties_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_specialty
logger.debug "set_specialty curr_user: " + current_user.inspect
          begin
            @specialty = Specialty.find(params[:id],:select => 'id, name')
          rescue ActiveRecord::RecordNotFound
            logger.error "Attempt to access invalid specialty #{params[:id]}"
            @specialty_not_found = true
            render json: {message: "Illegal specialty access request"}, status: :unauthorized
            return
          else
            @specialty_not_found = false
          end
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def specialty_params
          params.require(:specialty).permit(:name)
        end
    end
  end
end
