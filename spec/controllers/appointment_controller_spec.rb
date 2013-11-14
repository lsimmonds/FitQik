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
        expect(subject).to receive(:update).with(hash_including(:id => id.to_s))
        post :add, {id: id}
      end
    end

    context "when all paramters are passed" do
      it "creates a new appointment object" do
        pending
      end

      it "adds a student to the new appointment object" do
        pending
      end

      it "adds a teacher to the new appointment object" do
        pending
      end
    end

    context "when all paramters are not passed" do
      it "exits with a flash message" do
        pending
      end
    end
  end

  
  describe "POST 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end

    context "when all paramters are passed" do
      context "when a valid appointment id is passed in" do
        it "updates the new time value" do
          pending
        end
        context "when teacher is passed" do
          it "adds the teacher to the appointment" do
            pending
          end
        end
        context "when subject is passed" do
          it "changes to subject to the passed in one" do
            pending
          end
        end
        context "when student is passed" do
          it "adds the student to the appointment" do
            pending
          end
        end
      end

      context "when no valid appointment id is passed in" do
        context "when teacher, subject, and student are passed" do
          it "calls add" do
            pending
          end
        end
        context "when teacher, subject, and student are not passed" do
          it "exits with a flash message" do
            pending
          end
        end
      end
    end

  end

end
