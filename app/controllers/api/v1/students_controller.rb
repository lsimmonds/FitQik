module Api
  module V1
    class StudentsController < ApplicationController
      before_action :set_student, only: [:show, :edit, :update, :destroy]
      respond_to :json
      #acts_as_token_authentication_handler
    
      # GET /students
      # GET /students.json
      def index
        @students = Student.all
        #respond_to do |format|
        #  format.json { render json: @students, status: :ok }
        #end
        #render json: @students, status: :ok
        respond_with @students
      end

      def show_my_student
        @current_user = User.find_by email: params[:email]
	@student = @current_user.student
	if @student.nil?
          respond_with message: "none"
	else
          respond_with @student
	end
      end
    
      # GET /students/1
      # GET /students/1.json
      def show
        #render json: @student
        respond_with @student
      end
    
      # GET /students/new
      def new
        @student = Student.new
      end
    
      # GET /students/1/edit
      def edit
      end
    
      # POST /students
      # POST /students.json
      def create
        @student = Student.new(student_params)
        @current_user = User.find_by email: params[:email]
        @student.user_id = @current_user.id
    
        if @student.save
          #respond_with @student
          render json: @student
          #format.html { redirect_to @student, notice: 'Student was successfully created.' }
          #format.json { render action: 'show', status: :created, location: @student }
        else
          respond_with @student.errors, status: :unprocessable_entity
          #format.html { render action: 'new' }
          #format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    
      # PATCH/PUT /students/1
      # PATCH/PUT /students/1.json
      def update
        student_params.each_pair do |property,value|
          @student.send(property+'=',value)if @student.respond_to?(property+'=')
        end
        if @student.save
          set_student
          #respond_with @student
          render json: @student, status: :ok
        else
          ##render json: @student.errors, status: :unprocessable_entity
          respond_with @student.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /students/1
      # DELETE /students/1.json
      def destroy
        @student.destroy
        respond_to do |format|
          format.html { redirect_to students_url }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_student
          begin
            @student = Student.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            logger.error "Attempt to access invalid student #{params[:id]}"
            @student_not_found = true
            render json: {message: "Illegal student access request"}, status: :unauthorized
            return
          else
            @student_not_found = false
          end
          @current_user = User.find_by email: params[:email]
          render json: {message: "Illegal student access request"}, status: :unauthorized unless @current_user.id == @student.user_id
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def student_params
          params.require(:student).permit(:name)
        end
    end
  end
end
