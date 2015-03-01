module SessionsHelper
  
  def current_user
    cUser = !@current_user.nil? ? @current_user : user_from_remember_token
    puts "cUser = #{cUser}"
    puts "getCurrent_user.cUser(#{cUser}) "
    #  @current_user ||= user_from_remember_token
    cUser
  end
  
  def current_user=(user)
    puts "2. setCurrent_user(#{user})"
    @current_user = user
  end
  
  # Helper method to sign_in current user
  def sign_in(user)
    # save current_user in remember_token cookie
    self.current_user = user 
    cookies.permanent.signed[:remember_token] = [user.email, user.salt]  
  end
  
  def signed_in?
    #!cookies[:remember_token].nil?
    flag = !current_user.nil?
    puts "3. signed_in?(#{flag})"
    flag
  end
  
  def sign_out
    cookies.delete(:remember_token)
  #  cookies.delete(:current_user)
  end
  
  def check_navigation(user)
    nav_valid = @user.navigation.length > 0 ? true : false
    puts "signup.nav_valid(#{nav_valid})"
    if nav_valid
      puts
      redirect_to showuser_path(user.id)
    else
      redirect_to usernavigation_path(user.id)
    end
  end
  
  def deny_access
    redirect_to signin_path, :notice => "Please sign in to access this page"
  end
  
  private
  
    def user_from_remember_token
      puts "going to load user from #{remember_token}"
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      user_data = cookies.signed[:remember_token] || [nil,nil]
      puts "get user data from remember token #{user_data}"
      user_data
    end
    
    def authenticate
      deny_access unless signed_in?
    end
end
