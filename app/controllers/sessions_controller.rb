class SessionsController < ApplicationController
  
  #class << self; attr_accessor :current_user; attr_reader :current_user; end
  
  def new
    @title = "Sign in"
  end
  
  # Create Session method with ExceptionHandling for Runtime and ArgumentError
  def create
    puts "session.create.params[#{params}]"
    session = params[:session]
    email = session[:email]
    puts "going to authenticate user with email[#{email}] with session[#{session}]"
    path = :signin
    msg = "Authentication successfull!"
    @user = User.authenticate(email, session) if email != "" 
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
      navigations = Client.get_navigation(@user.id) if !@user.nil?
      puts "navigation = #{navigations}"
      @user.navigation = navigations
      puts "user already filled with navigation #{@user.navigation}" if !@user.navigation.nil?
      @user.show_navigation
      puts "1. sign_in(#{@user})"
      sign_in @user
      flash[:notice]= msg
      check_navigation(@user)
    else
      msg = "User could not be authenticated!"
      flash[:alert]= msg
      redirect_to signin_path
    end   
    @user 
  end
  
  def destroy
    sign_out
    redirect_to :controller => :sessions, :action => :new
  end
end
