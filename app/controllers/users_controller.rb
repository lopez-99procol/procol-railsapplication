class UsersController < ApplicationController
  
  attr_accessor :signup
  
  wrap_parameters format: [:json]
  
  # Route methods
  def signup
    @title = "Sign Up"
    puts "params = #{params}"
    if params[:commit] == "Sign up"
      #params = strip_params(params)
      #params[:user][:navigation] = {:label => "projects", :link => "http://sinatraprojects-procol.rhcloud.com/"}
      params.delete :utf8
      params.delete :authenticity_token
      params.delete :action
      params.delete :controller
      params.delete :commit
      
      puts "going to create user at #{ENV["SINATRA_BASE_URI"]} with params #{params}"
      response = Client.create(users_params)
      if response.is_a? Typhoeus 
        render_new("Could not process request")
        return
      end
      @user = response
      navigations = Client.get_navigation(@user.id)
      puts "navigation = #{navigations}"
      @user.navigation = navigations
      sign_in @user
       puts "signup.user #{@user}"
      if !@user.nil?
        flash[:success]="#{@user.name} #{@user.firstname} successfully registered!"
        check_navigation @user
      elsif
        flash[:error]="Could not create your user."
      end
    end
  end

  def profile
    params.delete :utf8
    params.delete :authenticity_token
    params.delete :action
    params.delete :controller
    params.delete :commit
    puts "profile.params = #{params}"
    navigation_id = params[:navigation_id]
    puts "profile to save for = #{params[:user_id]} contains navigation[#{navigation_id.to_s}]"
    Client.create_navigation(params)
    @user = current_user
  end

  def profile_load
    @user = current_user
  end
  
  def profile_save
    puts "users_params= #{users_params}"
    Client.update(current_user.id, users_params)
  end
  
  def show
    @title = "Show User"
  end
  
  def parse_response(response)
    return JSON.parse(response.body)
  end
  
  def clear_params(params)
    params.delete :utf8
    params.delete :authenticity_token
    params.delete :action
    params.delete :controller
    params.delete :commit
    params
  end
  
  private
    def users_params
      params.require(:user).permit(:name,:firstname,:email,:bio,:password,:password_confirmation,:encrypted_password,:salt,navigation: [:label, :link])
    end
end
