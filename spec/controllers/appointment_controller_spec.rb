require 'spec_helper'

describe AppointmentController do

  describe "POST 'add'" do
    it "returns http success" do
      get 'add'
      response.should be_success
    end

    context "when id is passed" do
      it "calls update" do
        id = double.as_null_object
        expect(controller).to receive(:update).with(hash_including(:id => id.to_s))
        post :add, {id: id}
      end
    end

    context "when all paramters are passed" do
      let(:student_id) { double }
      let(:teacher_id) { double }
      let(:when_var) { double }
      let(:subject) { double }
      let(:teacher) { double(:id => teacher_id) }
      let(:student) { double(:id => student_id) }
      let(:params) { {:student_id => student_id, :teacher_id => teacher_id, :when => when_var, :subject => subject} }
      let(:appt) { double.as_null_object }

      it "creates a new appointment object" do
        expect(Appointment).to receive(:create).with({:subject_id=>subject.to_s, :when=>when_var.to_s}).and_return(appt)
        allow(Teacher).to receive(:find).and_return(teacher)
        allow(appt.teachers).to receive(:push).with(teacher)
        allow(Student).to receive(:find).and_return(student)
        allow(appt.students).to receive(:push).with(student)
        post :add, params
      end

      it "adds a student to the new appointment object" do
        allow(Appointment).to receive(:create).with({:subject_id=>subject.to_s, :when=>when_var.to_s}).and_return(appt)
        allow(Teacher).to receive(:find).and_return(teacher)
        expect(appt.teachers).to receive(:push).with(teacher)
        allow(Student).to receive(:find).and_return(student)
        allow(appt.students).to receive(:push).with(student)
        post :add, params
      end

      it "adds a teacher to the new appointment object" do
        allow(Appointment).to receive(:create).with({:subject_id=>subject.to_s, :when=>when_var.to_s}).and_return(appt)
        allow(Teacher).to receive(:find).and_return(teacher)
        allow(appt.teachers).to receive(:push).with(teacher)
        allow(Student).to receive(:find).and_return(student)
        expect(appt.students).to receive(:push).with(student)
        post :add, params
      end
    end

    context "when all paramters are not passed" do
      it "exits with a flash message" do
        post :add
        expect(flash[:notice]).to eq("Must pass all parameters to schedule apointment")
      end
    end
  end

  
  describe "POST 'update'" do
    it "returns http success" do
      appt=double
      allow(Appointment).to receive(:find).and_return(appt)
      controller.instance_variable_set("@appointment", appt)
      allow(appt).to receive(:save)
      post 'update'
      response.should be_success
    end

    context "when a time parameter is passed" do
      let(:id) { double }
      let(:student_id) { double }
      let(:teacher_id) { double }
      let(:when_var) { double }
      let(:subject) { double }
      let(:teacher) { double(:id => teacher_id) }
      let(:student) { double(:id => student_id) }
      let(:params) { {:id => id, :student_id => student_id, :teacher_id => teacher_id, :when => when_var, :subject => subject} }
      let(:appt) { double(:when => when_var, :teachers => double, :students => double) }

      context "when a valid appointment id is passed in" do
        context "when a appointment time is passed in" do
          it "updates to the new time value" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            expect(appt).to receive(:when=).with(when_var.to_s)
            allow(appt).to receive(:save)
            post :update, params.except(:student_id,:teacher_id,:subject)
          end
        end
        context "when a appointment time is passed in" do
          it "does not update to the new time value" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            expect(appt).to_not receive(:when=).with(when_var.to_s)
            allow(appt).to receive(:save)
            post :update, params.except(:when,:student_id,:teacher_id,:subject)
          end
        end
        context "when teacher is passed" do
          it "adds the teacher to the appointment" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            allow(appt).to receive(:when=).with(when_var.to_s)
            allow(Teacher).to receive(:find).and_return(teacher)
            expect(appt.teachers).to receive(:push).with(teacher)
            allow(appt).to receive(:save)
            post :update, params.except(:student_id,:when,:subject)
          end
        end
        context "when no teacher is passed" do
          it "does not add the teacher to the appointment" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            allow(appt).to receive(:when=).with(when_var.to_s)
            allow(Teacher).to receive(:find).and_return(teacher)
            expect(appt.teachers).to_not receive(:push)
            allow(appt).to receive(:save)
            post :update, params.except(:student_id,:teacher_id,:subject)
          end
        end
        context "when student is passed" do
          it "adds the student to the appointment" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            allow(appt).to receive(:when=).with(when_var.to_s)
            allow(Student).to receive(:find).and_return(student)
            expect(appt.students).to receive(:push).with(student)
            allow(appt).to receive(:save)
            post :update, params.except(:teacher_id,:subject)
          end
        end
        context "when no student is passed" do
          it "does not add the student to the appointment" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            allow(appt).to receive(:when=).with(when_var.to_s)
            allow(Student).to receive(:find).and_return(student)
            expect(appt.students).to_not receive(:push).with(student)
            allow(appt).to receive(:save)
            post :update, params.except(:student_id,:teacher_id,:subject)
          end
        end
        context "when subject is passed" do
          it "changes subject to the passed in one" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            allow(appt).to receive(:when=).with(when_var.to_s)
            expect(appt).to receive(:subject=).with(subject.to_s)
            allow(appt).to receive(:save)
            post :update, params.except(:student_id,:teacher_id)
          end
        end
        context "when no subject is passed" do
          it "does not change subject to the passed in one" do
            allow(Appointment).to receive(:find).and_return(appt)
            controller.instance_variable_set("@appointment", appt)
            allow(appt).to receive(:when=).with(when_var.to_s)
            expect(appt).to_not receive(:subject=).with(subject.to_s)
            allow(appt).to receive(:save)
            post :update, params.except(:student_id,:teacher_id,:subject)
          end
        end
        it "saves the appointment" do
          allow(Appointment).to receive(:find).and_return(appt)
          controller.instance_variable_set("@appointment", appt)
          allow(appt).to receive(:when=).with(when_var.to_s)
          allow(appt).to receive(:subject=).with(subject.to_s)
          allow(Teacher).to receive(:find).and_return(teacher)
          allow(appt.teachers).to receive(:push)
          allow(Student).to receive(:find).and_return(student)
          allow(appt.students).to receive(:push).with(student)
          expect(appt).to receive(:save)
          post :update, params
        end
      end

      context "when no valid appointment id is passed in" do
        it "calls add" do
          expect(controller).to receive(:add)
          post :update, params.except(:id)
        end
      end
    end

  end

end
