module Api
  module V1
    class DisciplinesController < ApplicationController
      before_action :set_discipline, only: [:show, :edit, :update, :destroy]
      respond_to :json
      authorize_actions_for Discipline
      #authority_actions :update => 'read'

      #acts_as_token_authentication_handler
    
      # GET /disciplines
      # GET /disciplines.json
      def index
        @disciplines = Discipline.all
        #respond_to do |format|
        #  format.json { render json: @disciplines, status: :ok }
        #end
        #render json: @disciplines, status: :ok
        respond_with @disciplines
      end
    
      # GET /disciplines/1
      # GET /disciplines/1.json
      def show
        #render json: @discipline
        respond_with @discipline
      end
    
      # GET /disciplines/new
      def new
        @discipline = Discipline.new
      end
    
      # GET /disciplines/1/edit
      def edit
      end
    
      # POST /disciplines
      # POST /disciplines.json
      def create
logger.debug "create curr_user: " + current_user.inspect
        @discipline = Discipline.new(discipline_params)
        @discipline.creator_id = current_user
        @discipline.updater_id = current_user
logger.debug "discipline: "+@discipline.inspect
    
        if @discipline.save
          #respond_with @discipline
          render json: @discipline
          #format.html { redirect_to @discipline, notice: 'Discipline was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @discipline }
        else
          respond_with @discipline.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @discipline.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /disciplines/1
      # PATCH/PUT /disciplines/1.json
      def update
logger.debug "update discipline: "+@discipline.inspect
        discipline_params.each_pair do |property,value|
          @discipline.send(property+'=',value)if @discipline.respond_to?(property+'=')
        end
        @discipline.updater_id = current_user
        if @discipline.save
          set_discipline
          #respond_with @discipline
          render json: @discipline, status: :ok
        else
          ##render json: @discipline.errors, status: :unprocessable_entity
          respond_with @discipline.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /disciplines/1
      # DELETE /disciplines/1.json
      def destroy
        @discipline.destroy
        respond_to do |format|
          format.html { redirect_to disciplines_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_discipline
logger.debug "set_discipline curr_user: " + current_user.inspect
          begin
            @discipline = Discipline.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            logger.error "Attempt to access invalid discipline #{params[:id]}"
            @discipline_not_found = true
            render json: {message: "Illegal discipline access request"}, status: :unauthorized
            return
          else
            @discipline_not_found = false
          end
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def discipline_params
          params.require(:discipline).permit(:name,:description)
        end
    end
  end
end
