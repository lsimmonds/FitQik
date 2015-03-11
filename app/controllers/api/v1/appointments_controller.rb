module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_appointment, only: [:show, :teachers, :edit, :update, :destroy]
      respond_to :json
      authorize_actions_for Appointment
      authority_actions :update => 'update', :teachers => 'read'
    
      # GET /appointments.json
      def index
        @appointments = Appointment.all
        #render json: @appointments, status: :ok
        respond_with @appointments
      end
    
      # GET /appointments/1.json
      def show
        #render json: @appointment
        respond_with @appointment
      end
    
      def teachers
        #render json: @appointment
        respond_with @appointment.teachers
      end
    
      # POST /appointments.json
      def create
        if appointment?
          update
          return
        end
        unless !appointment_params[:student].nil? && !appointment_params[:student].empty? && !appointment_params[:teacher].nil? && !appointment_params[:teacher].empty? && appointment_params[:when] && appointment_params[:subject]
          #respond_with "Must pass student, teacher, time, and subject", status: :unprocessable_entity
          render json: {"message" => "Must pass student, teacher, time, and subject"}, status: :unprocessable_entity
          return
        else
          base_params = appointment_params.select {|k,v| k != "subject" && k != "student" && k != "teacher"}
logger.debug "base_params: "+base_params.inspect
logger.debug "base_params[:when]: "+base_params["when"].inspect
          base_params[:when] = DateTime.parse(base_params["when"]).strftime("%Y-%m-%d %H:%M:%S")
logger.debug "base_params[:when]: "+base_params["when"].inspect
          @appointment = Appointment.new(base_params)
          @appointment.creator=current_user
          @appointment.updater=current_user
          begin
            @appointment.subject= Subject.find(appointment_params[:subject][:id])
	    student_id = appointment_params[:student][0]?appointment_params[:student][0][:id]:appointment_params[:student]["0"][:id]
            @appointment.students.push(Student.find(student_id))
	    teacher_id = appointment_params[:teacher][0]?appointment_params[:teacher][0][:id]:appointment_params[:teacher]["0"][:id]
            @appointment.teachers.push(Teacher.find(teacher_id))
          rescue ActiveRecord::RecordNotFound => e
            render json: {"message" => e.to_s}
            return
          end
        end
logger.debug "appointment: "+@appointment.inspect
    
        if @appointment.save
          render json: @appointment
        else
          respond_with @appointment.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /appointments/1.json
      def update
logger.debug "in update: appointment_params: "+appointment_params.inspect;
        base_params = appointment_params.select {|k,v| k != "subject" && k != "student" && k != "teacher"}
        base_params.each_pair do |property,value|
          @appointment.send(property+'=',value)if @appointment.respond_to?(property+'=')
        end
        begin
          @appointment.subject= Subject.find(appointment_params[:subject][:id])
          @appointment.students=[]
          appointment_params[:student].each do |student|
	    student_id = student[1].nil? ? student[:id] : student[1][:id]
            @appointment.students.push(Student.find(student_id))
          end
          @appointment.teachers=[]
          appointment_params[:teacher].each do |teacher|
logger.debug "teacher: "+teacher.inspect
	    teacher_id = teacher[1].nil? ? teacher[:id] : teacher[1][:id]
            @appointment.teachers.push(Teacher.find(teacher_id))
          end
        rescue ActiveRecord::RecordNotFound => e
          render json: {"message" => e.to_s}
          return
        end
        if @appointment.save
          set_appointment
          render json: @appointment, status: :ok
        else
          ##render json: @appointment.errors, status: :unprocessable_entity
          respond_with @appointment.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /appointments/1.json
      def destroy
        @appointment.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end
    
      private

      def appointment?
        appointment_params[:id] && !appointment_params[:id].empty? && appointment_params[:id] != "0"
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_appointment
        begin
          @appointment = Appointment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          logger.error "Attempt to access invalid appointment #{params[:id]}"
          @appointment_not_found = true
          render json: {message: "Illegal appointment access request"}, status: :unauthorized
          return
        else
          @appointment_not_found = false
        end
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def appointment_params
logger.debug "In appointment_params "+params.inspect
#In appointment_params{"token"=>"B4JzNFq_aCN61fyhqxG5", "email"=>"fqtest@leonsimmonds.com", "format"=>"json", "controller"=>"api/v1/appointments", "action"=>"create", "appointment"=>{}}
        params.require(:appointment).permit( :id, :when, :length, :status, :subject => [[:id]], :student => [[:id]],:teacher => [[:id]] )
      end
    end
  end
end
