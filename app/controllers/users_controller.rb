class UsersController < ApplicationController
  attr_accessor :user
  
  def signup
    @title = "Sign Up"
    puts "params = #{params}"
    if params[:commit] == "Sign up"
      params.delete :utf8
      params.delete :authenticity_token
      params.delete :action
      params.delete :controller
      params.delete :commit
      puts "going to create user at #{ENV["SINATRA_BASE_URI"]} with params #{params.to_json}"
      response = Client.create(params)
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
      return @user
    end
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
    return @user
  end
  
  def parse_response(response)
    return JSON.parse(response.body)
  end
  
  def render_new(msg)
    @title = "Sign up"
    flash.now[:error] = msg
    render 'signup'
  end
end
