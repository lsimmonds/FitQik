require 'spec_helper'

describe "teachers/index" do
  before(:each) do
    assign(:teachers, [
      stub_model(Teacher),
      stub_model(Teacher)
    ])
  end

  it "renders a list of teachers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
