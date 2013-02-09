class HomeController < ApplicationController
  def index
    @user = User.find(current_user)
  end
end
