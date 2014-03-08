require 'spec_helper'

describe Api::V1::TransactionsController do

  describe "GET 'record'" do
    it "returns http success" do
      get 'record'
      response.should be_success
    end
  end

end
