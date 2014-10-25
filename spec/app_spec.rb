require 'spec_helper'

describe ApplicationController do
  render_views
  
  describe "Layout" do
    it "should show the proper title" do
     expect(response).to have_selector("title", :content => "Project-Collaboration")
    end
  end
end