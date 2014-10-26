require 'rails_helper'

RSpec.describe "LayoutLinks", :type => :request do
  describe "header links" do
    
    it "should show Help" do
      expect(:get => '/help').to have_selector('title', :content => "Help")
    end
    
    it "should show Sign Up" do
      get '/signup'
      expect(response).to have_selector('title', :content => "Sign Up")
    end
    
    it "should show Sign In" do
      get '/signin'
      expect(response).to have_selector('title', :content => "Sign In")
    end
    
  end
  
  describe "footer links" do
    
    it "should show About website" do
      get '/about'
      expect(response).to have_selector('title', :content => "About")
    end
    
    it "should show Contact website" do
      get '/contact'
      expect(response).to have_selector('title', :content => "Contact")
    end
    
    it "should show ProCol website" do
      get '/procol'
      expect(response).to have_selector('title', :content => "99ProcCol")
    end
    
  end
end
