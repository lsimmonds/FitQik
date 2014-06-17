module Api
  module V1
    class TeachersController < ApplicationController
      before_action :set_teacher, only: [:show, :edit, :update, :destroy, :show_appoinments, :get_day_map]
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
    
      def show_appoinments
        respond_with @teacher.appointments
      end

      def get_day_map
	date = params[:date]
	appts = @teacher.appointments.on_date(date)
	short_index_appts = {}
	appts.each do |appointment|
	  short_index_appts[appointment.when.time.localtime("-08:00").strftime("%H%M")]=appointment
	end
logger.debug "In get_day_map: short_index_appts = "+short_index_appts.inspect
	day_map = {date => {}}
	("00".."24").each do |hour|
	  ("00".."59").step(30).each do |min|
	    day_map["#{date}"]["#{hour}#{min}"] = short_index_appts["#{hour}#{min}"].nil? ? {} : short_index_appts["#{hour}#{min}"]
	  end
	end
	render json: day_map
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
logger.debug "looking at teach["+property.to_s+"]="+value.to_s+" teacher.respond_to?("+property+"'=')"+@teacher.respond_to?(property+'=').to_s
          @teacher.send(property+'=',value) if @teacher.respond_to?(property+'=')
        end
        if @teacher.save
          #set_teacher
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
          begin
            @teacher = Teacher.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            logger.error "Attempt to access invalid teacher #{params[:id]}"
            @teacher_not_found = true
            render json: {message: "Illegal teacher access request"}, status: :unauthorized
            return
          else
            @teacher_not_found = false
          end
	  #Let everyone see all teachers for now, may have to refine later
          #@current_user = User.find_by email: params[:email]
          #render json: {message: "Illegal teacher access request"}, status: :unauthorized unless @current_user.id == @teacher.user_id
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def teacher_params
logger.debug "In teacher_params: params: "+params.inspect
          params.require(:teacher).permit(:name,:bio,:about,:skill,:specialty,:certification,:date)
        end
    end
  end
end
