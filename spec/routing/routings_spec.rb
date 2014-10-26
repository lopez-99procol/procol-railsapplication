require "rails_helper"

RSpec.describe "routes to controller" do
  it "routes /users/register to UsersController register" do
    expect(:get => "/signup").to route_to(:controller => "users", :action => "signup")
  end
  
  it "routes /users/login to UsersController login" do
    expect(:get => "/signin").to route_to(:controller => "users", :action => "signin")
  end
  
  it "routes /users/<id> to UsersController show" do
    expect(:get => "/users/1").to route_to(:controller => "users", :action => "show", :id => "1")
  end
  
end