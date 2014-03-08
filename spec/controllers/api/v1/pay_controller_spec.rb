require 'spec_helper'

describe Api::V1::PayController do

  describe "GET 'auth'" do
    it "returns http success" do
      get 'auth'
      response.should be_success
    end
  end

  describe "GET 'pay'" do
    it "returns http success" do
      get 'pay'
      response.should be_success
    end
  end

end
