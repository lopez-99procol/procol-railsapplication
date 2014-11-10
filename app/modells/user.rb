require_dependency 'client.rb'

class User 
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations
  
  attr_accessor :id, :name, :firstname, :email, :bio, :password, :password_confirmation, :encrypted_password, :salt
  
  validate :name, :email, :password, :password_confirmation, :salt, presence: true
  
  def attributes=(hash)
    hash.each do |key, value|
      #puts "loading #{key} with #{value}"
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end
  
  def to_json
    super(:except => [:password, :encrypted_password, :salt])
  end
  
  def to_s
    self.to_json
  end
  
  def self.authenticate(email, password)
    response = Client.find_by_email(email)
    return nil if response.is_a? Typhoeus
    user = response
    puts "authenticate.user = #{user.to_s}"
    if user.nil?
       return nil
    else
      puts "authenticate.user.email[#{user.email}] authenticate.user.password[#{user.password}]"
      return user
    end
  end
  
  def self.authenticate_with_salt(email, cookie_salt)
    response = Client.find_by_email(email)
    return nil if response.is_a? Typhoeus
    user = response
    puts "authenticate_with_salt.user = #{user.to_s}"
    (user && user.salt == cookie_salt) ? user : nil
  end
    
end
  
  
