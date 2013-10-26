require 'spec_helper'

describe "teachers/show" do
  before(:each) do
    @teacher = assign(:teacher, stub_model(Teacher))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
