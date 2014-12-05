require_dependency 'client.rb'

module UsersHelper  
  def load_userprofile(user)
    puts "profile to load for = #{user}"
    
    @navigation = Client.get_navigation(user.id) if !user.nil?
    if !@navigation.nil?
      puts "found #{@navigation}"
    end
  end
end
