class HomeController < ApplicationController
  def index
    flash[:notice] = "HomeController#index"
    @users = User.all
  end
end
