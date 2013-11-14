class AppointmentController < ApplicationController
  before_action :set_appointment, only: [:show, :add]

  def add
    unless params[:student_id] && params[:teacher_id] && params[:when] && params[:subject]
      flash[:notice] = "Must pass all parameters to schedule apointment"
    else
      if @appointment_not_found
        @appointment = appt = Appointment.create(:subject_id => params[:subject], :when => params[:when])
      else
        @appointment.when = params[:when]
      end
      @appointment.teachers.push(Teacher.find(params[:teacher_id]))
      @appointment.students.push(Student.find(params[:student_id]))
    end
  end

  def show
  end

  private

  def appointment_params
    params.require(:appointment).permit(:id, :student_id, :teacher_id, :when, :subject)
  end

  def set_appointment
    begin
      @appointment = Appointment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      #logger.error "Attempt to access invalid appointment #{params[:id]}"
      @appointment_not_found = true
    else
      @appointment_not_found = false
    end
  end
end
