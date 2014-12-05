class PagesController < ApplicationController
  def home
    @title = "Welcome"
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
