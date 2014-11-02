require 'spec_helper'

RSpec.describe "Users", :type => :view do
  
  describe "signup" do
  
    describe "failure" do 
  
      it "should fail to make a new user" do
        expect {
          visit signup_path
          fill_in "Name",         :with =>  ""
          fill_in "Firstname",    :with =>  ""
          fill_in "Bio",          :with =>  ""
          fill_in "Password",     :with =>  ""
          fill_in "Confirmation", :with =>  ""
          click_button
          #expect(response).to have_selector("div#error_explanation")
          #expect(response).to render_template('users/signup')
        }.to_not have_selector("div#error_explanation")
      end
      
    end
    
    describe "success" do
      
      it "should not make a new user" do
        expect{
          visit signup
          fill_in "Name",         :with =>  "Lopez"
          fill_in "Firstname",    :with =>  "99centprocol-lopez@gmail.com"
          fill_in "Bio",          :with =>  "digital nomad"
          fill_in "Password",     :with =>  "Password1"
          fill_in "Confirmation:",:with =>  "Password1"
          click_button
          expect(response).to render_template('users/signup')
        }.to change(User, :to_json)
      end
    end
  end
end
