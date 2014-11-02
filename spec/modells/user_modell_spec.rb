require 'rails_helper'
require 'rspec/expectations'
require_dependency 'client.rb'

RSpec.describe "Users" do 
  
  before(:all) do
    @json_data = {name: 'Peter Hase', email: 'peter.hase@gmail.com', password: 'fuchs', password_confirmation: 'fuchs', bio: 'Ein Waldbewohner'}
    @user = User.new
  end
  
  it "should return a new User instance" do
    expect(@user).to be_instance_of(User)
  end
  
  it "should fill a User from_json" do
    @user.from_json(@json_data.to_json)
    expect(@user.firstname).to eq(@json_data[:firstname])
  end
  
  it "should authenticate the user" do
    email = "99centprocol-lopez@gmail.com", 
    password = "whatever"
    expect(User.authenticate(email,password)).to eq(true)
  end
  
  it "user should have a firstname property" do
    user = User.find(1)
    expect(user.to_json).to include("firstname")
  end
  
end
