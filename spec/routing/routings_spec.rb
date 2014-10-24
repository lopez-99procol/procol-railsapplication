require "rails_helper"

RSpec.describe "routes to controller" do
  it "routes /users/register to UsersController register" do
    expect(:get => "/users/register").to route_to(:controller => "users", :action => "register")
  end
  
  it "routes /users/login to UsersController login" do
    expect(:get => "/users/login").to route_to(:controller => "users", :action => "login")
  end
  
  it "routes /users/<id> to UsersController show" do
    expect(:get => "/users/lopez").to route_to(:controller => "users", :action => "show")
  end
  
end