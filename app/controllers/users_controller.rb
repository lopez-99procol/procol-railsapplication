class UsersController < ApplicationController
  def register
    @title = "register"
  end

  def login
    @title = "login"
  end
  
  def show
    User.find_by_name(params[:id])
  end
end
