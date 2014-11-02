require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "should have the right title" do
      get :new
      expect(response).to have_selector('title', :text => "Sign in")
    end
  end

 describe "POST" do
   before(:each) do
     json = %q({"id":1,"name":"Krueger","email":"t.krueger@mac.com","bio":"digital nomad","encrypted_password":"7bdaebec0f8e175ff17f91b93b497945fdc4afd8cf2562484d037f3fdd5fff3d","salt":"3287b07032747c6522ed6c7ca09b4c40e543306907105c21a37f5f205a587ffd","firstname":"Thomas"})
     @user = User.new.from_json(json)
     @attr = {:email => "t.krueger@mac.com", :password => @user.password}
   end
   
   it "should sign the user in" do
     post :create, :session => @attr
     expect(controller.current_user).to eq(@user)
     expect(controller.current_user).to be_signed_in
   end
   
   it "should redirect to the user show page" do
     post :create, :session => @attr
     expect(response).to redirect_to(showuser_path(@user))
   end
 end

end
