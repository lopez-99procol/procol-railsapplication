require 'rails_helper'

RSpec.describe UsersController do
  render_views

  describe "GET signup" do
    it "returns http success" do
      get 'signup'
      expect(response).to have_http_status(:success)
    end
    
    it "should create an user" do
      post 'signup', {
          :name     => "EHGSBYID",
          :email    => "no spam",
          :password => "whatever",
          :password_confirmation => "whatever",
          :bio      => "southern bell"}.to_json
      expect(response).to have_http_status(:success)
      puts "#{response.body}"
    end
  end

  describe "GET signin" do
    it "returns http success" do
      get 'signin'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get '/show/1'
      expect(response).to have_http_status(:success)
    end
  end
  
end
