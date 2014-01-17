module Api
  module V1
    class TeachersController < ApplicationController
      before_action :set_teacher, only: [:show, :edit, :update, :destroy]
      respond_to :json
    
      # GET /teachers.json
      def index
        @teachers = Teacher.all
        #render json: @teachers, status: :ok
        respond_with @teachers
      end
    
      # GET /teachers/1.json
      def show
        #render json: @teacher
        respond_with @teacher
      end
    
      # GET /teachers/new
      def new
        @teacher = Teacher.new
      end
    
      # GET /teachers/1/edit
      def edit
      end
    
      # POST /teachers.json
      def create
        @teacher = Teacher.new(teacher_params)
        @current_user = User.find_by email: params[:email]
        @teacher.user_id = @current_user.id
    
        if @teacher.save
          render json: @teacher
        else
          respond_with @teacher.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /teachers/1.json
      def update
        teacher_params.each_pair do |property,value|
          @teacher.send(property+'=',value)if @teacher.respond_to?(property+'=')
        end
        if @teacher.save
          set_teacher
          #respond_with @teacher
          render json: @teacher, status: :ok
        else
          ##render json: @teacher.errors, status: :unprocessable_entity
          respond_with @teacher.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /teachers/1.json
      def destroy
        @teacher.destroy
        respond_to do |format|
          format.html { redirect_to teachers_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_teacher
          @teacher = Teacher.find(params[:id])
          @current_user = User.find_by email: params[:email]
          render json: {message: "Illegal teacher access request"}, status: :unauthorized unless @current_user.id == @teacher.user_id
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def teacher_params
          params.require(:teacher).permit(:name)
        end
    end
  end
end
