require_dependency 'client.rb'

class User 
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations
  
  attr_accessor :id, :name, :email, :bio, :password, :password_confirmation, :encrypted_password
  
  validate :name, :email, :password, :password_confirmation, presence: true
  
  def attributes=(hash)
    hash.each do |key, value|
      puts "loading #{key} with #{value}"
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end
    
  def to_s
    self.to_json
  end
  
  def self.authenticate(email, password)
    test = false
    puts "email[#{email}] password[#{password}]"
    test = (email.length > 0) || false
    test = (password.length > 0) || false

    return test
  end
    
end
  
  
