class HomeController < ApplicationController
  def index
    @user = User.find(current_user)
    @available = User.available
  end
end
