require_dependency 'client.rb'

class UsersController < ApplicationController
  attr_accessor :user
  def initialize
    super
    Client.base_uri = "http://localhost:4567" 
  end
  
  def signup
    @title = "Sign Up"
    
    if params[:action] == "signup"
      params.delete :utf8
      params.delete :authenticity_token
      params.delete :action
      params.delete :controller
      params.delete :commit
      puts "going to create user with params #{params.to_json}"
      @userresponse= Client.create(params)
      puts "userresponse #{@userresponse}"
      if @userresponse.code == 200
        user = JSON.parse(@userresponse.body)
        redirect_to :controller => 'users', :action => 'show', :id => user['id']
      end
      return @userresponse
    end
  end

  def signin
    @title = "Sign In"
    
  end

  def show
    @title = "Show User"
    
    return nil if params[:id].nil?
    @userresponse= Client.find(params[:id])
    @userdata = parse_response(@userresponse)
    puts "user => #{@userdata.to_s}"
    return @userdata
  end
  
  def parse_response(response)
    return JSON.parse(response.body)
  end
end
