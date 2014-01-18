module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_appointment, only: [:show, :edit, :update, :destroy]
      respond_to :json
    
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
    
      # POST /appointments.json
      def create
        if appointment?
          set_appointment
          update
          return
        end
        unless !appointment_params[:student].empty? && !appointment_params[:teacher].empty? && appointment_params[:when] && appointment_params[:subject]
          respond_with "Must pass student, teacher, time, and subject", status: :unprocessable_entity
        else
          base_params = appointment_params.select {|k,v| k != "subject" && k != "student" && k != "teacher"}
          @appointment = Appointment.new(base_params)
          begin
            @appointment.subject= Subject.find(appointment_params[:subject][:id])
            appointment_params[:student].each do |student|
              @appointment.students.push(Student.find(student[:id]))
            end
            appointment_params[:teacher].each do |teacher|
              @appointment.teachers.push(Teacher.find(teacher[:id]))
            end
          rescue ActiveRecord::RecordNotFound => e
            render json: {"message" => e.to_s}
            return
          end
        end
    
        if @appointment.save
          render json: @appointment
        else
          respond_with @appointment.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /appointments/1.json
      def update
        base_params = appointment_params.select {|k,v| k != "subject" && k != "student" && k != "teacher"}
        base_params.each_pair do |property,value|
          @appointment.send(property+'=',value)if @appointment.respond_to?(property+'=')
        end
        begin
          @appointment.subject= Subject.find(appointment_params[:subject][:id])
          @appointment.students=[]
          appointment_params[:student].each do |student|
            @appointment.students.push(Student.find(student[:id]))
          end
          @appointment.teachers=[]
          appointment_params[:teacher].each do |teacher|
            @appointment.teachers.push(Teacher.find(teacher[:id]))
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
        params.require(:appointment).permit( :id, :when, :subject => [:id],:student => [[:id]],:teacher => [[:id]] )
      end
    end
  end
end
