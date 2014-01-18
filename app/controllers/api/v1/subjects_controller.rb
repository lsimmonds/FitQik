module Api
  module V1
    class SubjectsController < ApplicationController
      before_action :set_subject, only: [:show, :edit, :update, :destroy]
      respond_to :json
      #acts_as_token_authentication_handler
    
      # GET /subjects
      # GET /subjects.json
      def index
        @subjects = Subject.all
        #respond_to do |format|
        #  format.json { render json: @subjects, status: :ok }
        #end
        #render json: @subjects, status: :ok
        respond_with @subjects
      end
    
      # GET /subjects/1
      # GET /subjects/1.json
      def show
        #render json: @subject
        respond_with @subject
      end
    
      # POST /subjects
      # POST /subjects.json
      def create
        base_params = subject_params.select {|k,v| k != "discipline"}
        @subject = Subject.new(base_params)
        @subject.discipline= Discipline.find(subject_params[:discipline][:id])
    
        if @subject.save
          #respond_with @subject
          render json: @subject
          #format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @subject }
        else
          respond_with @subject.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @subject.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /subjects/1
      # PATCH/PUT /subjects/1.json
      def update
        base_params = subject_params.select {|k,v| k != "discipline"}
        base_params.each_pair do |property,value|
          @subject.send(property+'=',value)if @subject.respond_to?(property+'=')
        end
        @subject.discipline= Discipline.find(subject_params[:discipline][:id])
        if @subject.save
          set_subject
          #respond_with @subject
          render json: @subject, status: :ok
        else
          ##render json: @subject.errors, status: :unprocessable_entity
          respond_with @subject.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /subjects/1
      # DELETE /subjects/1.json
      def destroy
        @subject.destroy
        respond_to do |format|
          format.html { redirect_to subjects_url }
          format.json { head :no_content }
        end
      end
    
      private

      # Use callbacks to share common setup or constraints between actions.
      def set_subject
        begin
          @subject = Subject.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          logger.error "Attempt to access invalid subject #{params[:id]}"
          @subject_not_found = true
          render json: {message: "Illegal subject access request"}, status: :unauthorized
          return
        else
          @subject_not_found = false
        end
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def subject_params
        params.require(:subject).permit(:id, :name, :description, :discipline => [:id, :name, :description])
      end
    end
  end
end
