require_dependency 'client.rb'

module UsersHelper  
  def load_userprofile(user)
    puts "profile to load for = #{user}"
    
    load_navigation(user.id) if !user.nil?
  end
  
  def load_navigation(userID)
    puts "navigation to load for user with id = #{userID}"
    navigation = Navigation.new
    
    puts "rb: #{response_body}"
    
    # Transform to JSON     
    rb_hash = JSON.parse(response_body)
    
    # Print JSON result
    rb_hash.each { |pair| print pair}
    
    # Modify JSON Hash
    #rb_hash.delete("created_at")
    #rb_hash.delete("updated_at")
    
    puts
    #puts "hash: #{rb_hash}"
    
    # Put the hash back to json string format
    json_data = rb_hash.to_json
    
    navigation.from_json(json_data)
    #puts "user.to_s = #{user.to_s}"
    navigation
  end
end
