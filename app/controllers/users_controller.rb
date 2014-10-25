require_dependency 'client.rb'

class UsersController < ApplicationController

  def initialize
    Client.base_uri = "http://localhost:4567"
  end
  
  def register
    @title = "Sign Up to 99CentProCol"
  end

  def login
    @title = "Login to 99CentProCol"
  end
  
  def show
    @title = "Show user at 99CentProCol"
    
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
