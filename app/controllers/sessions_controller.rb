class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    
    puts "create.params => #{params}"
    if params[:session][:email] != "" && params[:session][:password] != ""
      @user = User.authenticate(params[:session][:email],params[:session][:password])
      if @user.nil?
        render_new("Invalid email/password combination")
      else
        # sign user in
        sign_in @user
        redirect_to :controller => 'users', :action => 'show', :id => @user.id
      end
    else
      render_new("Please provide login data")
    end
  end
  
  def destroy
    
  end
  
  def render_new(msg)
    @title = "Sign in"
    flash.now[:error] = msg
    render 'new'
  end
  
end
