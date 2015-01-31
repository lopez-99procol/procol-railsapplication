require_dependency 'client.rb'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  #include UsersHelper
  include ApplicationHelper


  def initialize
    super
    Client.base_uri = ENV["SINATRA_BASE_URI"] #"http://localhost:9292" #"http://sinatrausers-procol.rhcloud.com" 
  end
  
  def not_found
    render 'shared/4oh4'
  end
  
end
