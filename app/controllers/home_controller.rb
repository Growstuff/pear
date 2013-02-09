class HomeController < ApplicationController
  def index
    @user = current_user ? User.find(current_user) : User.new
    @available = User.available
  end
end
