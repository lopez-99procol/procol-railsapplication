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
    
end
  
  
