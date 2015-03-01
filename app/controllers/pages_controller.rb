class PagesController < ApplicationController
  def home
    @title = "Welcome"
    @micropost = Micropost.new if signed_in?
  end

  def contact
    @title = "Contact"
  end

  def help
    @title = "Help"
  end
  
  def about
    @title = "About"
  end
  
  def procol
    @title = "99ProCol"
  end
  
  def demo
    @title = "Demo"
  end
  
end
