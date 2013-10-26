class StaticController < ApplicationController
  def home
  end

  def help
  end

  def contact
  end

  def about_us
    flash[:notice] = "This is the about us page"
  end
end
