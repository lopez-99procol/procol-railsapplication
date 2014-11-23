class UsersController < ApplicationController
  attr_accessor :user
  
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
      puts "signup.user #{user}"
      if !@user.nil?
        flash[:success]="#{@user.name} successfully registered!"
        redirect_to :controller => 'users', :action => 'show', :id => @user.id
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
    puts "profile to save for = #{params[:user_id]} contains navigations[#{params[:navigations_id]}]"
    Client.create_users_profile(params)
  end

  def signin
    @title = "Sign in"
    
  end

  def show
    @title = "Show User"
    
    return nil if params[:id].nil?
    response= Client.find(params[:id])
    return nil if response.is_a? Typhoeus
    @user = response
    puts "user => #{@userdata.to_s}"
    #redirect_to :controller => 'users', :action => 'navigation', :id => @user.id
  end
  
  def parse_response(response)
    return JSON.parse(response.body)
  end
  
  private
    def users_params
      params.require(:user).permit(:name,:firstname,:email,:password,:password_confirmation,:encrypted_password, :salt, navigation: [:label, :link])
    end
end
