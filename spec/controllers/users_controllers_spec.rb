require 'spec_helper'

describe UserController do
  render_views
  
  describe "GET 'login'" do
  
    it "should be successful" do
      get 'login'
      expect(response).to be_success
    end
    
    it "should have the right title" do
      get 'login'
      expect(response).to have_selector("title", :content => "Login")
    end
  end
  