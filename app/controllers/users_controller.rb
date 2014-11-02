require_dependency 'client.rb'

class UsersController < ApplicationController
  attr_accessor :user
  def initialize
    super
    Client.base_uri = ENV["SINATRA_BASE_URI"] #"http://localhost:9292" #"http://sinatrausers-procol.rhcloud.com" 
  end
  
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
      @userresponse= Client.create(params)
      puts "userresponse #{@userresponse}"
      if @userresponse.code == 200
        user = JSON.parse(@userresponse.body)
        redirect_to :controller => 'users', :action => 'show', :id => user['id']
      elsif
        flash[:error]="Could not create your user."
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
