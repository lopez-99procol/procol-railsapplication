require_dependency 'client.rb'

class UsersController < ApplicationController

  def initialize
    Client.base_uri = "http://localhost:4567"
  end
  
  def signup
    @title = "Sign Up"
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
    return @userresponse
  end
  
  def parse_response(response)
    return JSON.parse(response.body)
  end
end
