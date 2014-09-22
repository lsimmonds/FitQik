module Api
  module V1
    class SkillsController < ApplicationController
      before_action :set_skill, only: [:show, :edit, :update, :destroy]
      respond_to :json
      authorize_actions_for Skill
      #acts_as_token_authentication_handler
    
      # GET /skills
      # GET /skills.json
      def index
        @skills = Skill.find(:all,:select => 'id, name')
        #respond_to do |format|
        #  format.json { render json: @skills, status: :ok }
        #end
        #render json: @skills, status: :ok
        respond_with @skills
      end
    
      # GET /skills/1
      # GET /skills/1.json
      def show
        #render json: @skill
        respond_with @skill
      end
    
      # GET /skills/new
      def new
        @skill = Skill.new
      end
    
      # GET /skills/1/edit
      def edit
      end
    
      # POST /skills
      # POST /skills.json
      def create
        @skill = Skill.new(skill_params)
    
        if @skill.save
          #respond_with @skill
          render json: @skill
          #format.html { redirect_to @skill, notice: 'Skill was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @skill }
        else
          respond_with @skill.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @skill.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /skills/1
      # PATCH/PUT /skills/1.json
      def update
        skill_params.each_pair do |property,value|
          @skill.send(property+'=',value)if @skill.respond_to?(property+'=')
        end
        @skill.updater_id = current_user
        if @skill.save
          set_skill
          #respond_with @skill
          render json: @skill, status: :ok
        else
          ##render json: @skill.errors, status: :unprocessable_entity
          respond_with @skill.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /skills/1
      # DELETE /skills/1.json
      def destroy
        @skill.destroy
        respond_to do |format|
          format.html { redirect_to skills_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_skill
          begin
            @skill = Skill.find(params[:id],:select => 'id, name')
          rescue ActiveRecord::RecordNotFound
            logger.error "Attempt to access invalid skill #{params[:id]}"
            @skill_not_found = true
            render json: {message: "Illegal skill access request"}, status: :unauthorized
            return
          else
            @skill_not_found = false
          end
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def skill_params
          params.require(:skill).permit(:name)
        end
    end
  end
end
