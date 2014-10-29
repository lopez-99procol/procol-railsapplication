class SessionsController < ApplicationController
  def new
    @title = "Sign Up"
  end
  
  def create
    result = User.authenticate(params[:session][:email],params[:session][:password])
    
    puts "result = #{result}"
    
    if result == false
      flash.now[:error] = "Invalid email/password combination"
      
      @title = "Sign In"
      render 'new'
    else
      # sign user in
      redirect_to user_path :id => 1
    end
  end
  
  def destroy
    
  end
end
