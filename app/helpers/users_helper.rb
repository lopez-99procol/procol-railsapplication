module UsersHelper  
  def load_userprofile(user)
    puts "profile to load for = #{user}"
    
    load_navigation(user.id) if !user.nil?
  end
  
  def load_navigation(userID)
    puts "navigation to load for user with id = #{userID}"
    
  end
end
