class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  # Create Session method with ExceptionHandling for Runtime and ArgumentError
  def create
    path = :signin
    msg = "Authentication successfull!"
    @user = User.authenticate(params[:session][:email], params[:session]) if params[:session][:email] != "" 
  rescue RuntimeError => rEx
    msg = rEx
    puts "create: RuntimeError '#{rEx}' occured"
    not_found
  rescue ArgumentError => aEx
    msg = aEx
    puts "create: ArgumentError '#{aEx}' occured"
    not_found
  else
    if !@user.nil?
      sign_in @user 
      flash[:notice]= msg
      redirect_to showuser_path(@user.id)
    else
      msg = "User could not be authenticated!"
      flash[:alert]= msg
      redirect_to signin_path
    end    
  end
  
  def destroy
    sign_out
    flash[:notice]= "See you soon!"
    redirect_to signin_path
  end
  
end
