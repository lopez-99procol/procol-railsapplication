class MicropostsController < ApplicationController
  before_filter :authenticate
  
  def create
    params.delete :utf8
    params.delete :authenticity_token
    params.delete :action
    params.delete :controller
    params.delete :commit
    
    puts "MicropostsController:create(params[#{params}])"
    puts "MicropostsController:create(micropost_params[#{micropost_params}])"    
    
    micropost = Client.create_micropost(current_user.id, params)
  
    if !micropost.nil?
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
  
  def destroy
    
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
  
end