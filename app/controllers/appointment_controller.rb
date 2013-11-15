class AppointmentController < ApplicationController
  before_action :set_appointment, only: [:show, :add, :update]

  def add
    if params[:id] && !params[:id].empty? && params[:id] != "0"
      update params
      return
    end
    unless params[:student_id] && params[:teacher_id] && params[:when] && params[:subject]
      flash[:notice] = "Must pass all parameters to schedule apointment"
    else
      @appointment = Appointment.create(:subject_id => params[:subject], :when => params[:when])
      @appointment.teachers.push(Teacher.find(params[:teacher_id]))
      @appointment.students.push(Student.find(params[:student_id]))
    end
  end

  def update
    if @appointment_not_found
      params[:id] = nil
      add
      return
    else
      if params[:when]
        @appointment.when = params[:when]
      end
      if params[:subject]
        @appointment.subject = params[:subject]
      end
      if params[:teacher_id]
        @appointment.teachers.push(Teacher.find(params[:teacher_id]))
      end
      if params[:student_id]
        @appointment.students.push(Student.find(params[:student_id]))
      end
      @appointment.save
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
