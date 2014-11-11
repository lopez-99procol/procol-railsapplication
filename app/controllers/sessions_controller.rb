class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  # Create Session method with ExceptionHandling for Runtime and ArgumentError
  def create
    path = :signin
    msg = "Authentication successfull!"
    @user = User.authenticate(params[:session][:email],params[:session][:password]) if params[:session][:email] != "" && params[:session][:password] != "" 
  rescue RuntimeError => rEx
    msg = rEx
    puts "create: RuntimeError '#{rEx}' occured"
  rescue ArgumentError => aEx
    msg = rEx
    puts "create: ArgumentError '#{rEx}' occured"
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
