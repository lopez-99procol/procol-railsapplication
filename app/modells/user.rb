require_dependency 'client.rb'

class User 
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations
  
  attr_accessor :id, :name, :firstname, :email, :bio, :password, :password_confirmation, :encrypted_password, :salt, :userprofile, :navigation
  
  validate :name, :email, :password, :password_confirmation, :salt, presence: true
  
  def initialize
    @navigation = []
  end
  
  def attributes=(hash)
    hash.each do |key, value|
      puts "loading #{key} with #{value}"
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
  
  def show_navigation
    @navigation.each do |i|
      puts "i.to_s[#{i.to_s}]"
    end
  end
  
  def self.authenticate(email, attributes)
    puts "authenticate user"
    user = Client.signin(email, attributes)
    puts "authenticated user[#{user}]"    
  rescue RuntimeError => rEx
    puts "RuntimeError[#{rEx}] occured"
    user = nil
    raise RuntimeError, "user: User authentication failed!", caller
  rescue ArgumentError => aEx
    puts "user: ArgumentError '#{aEx}' occured"
    user = nil
    raise ArgumentError, "Wrong user credentials, authentication failed", caller
  rescue Exception => ex
    puts "Exception '#{ex}' occured"
  else
    puts "went do else instead of rescue"
    user = response
  ensure
    return user
  end
  
  def self.authenticate_with_salt(email, cookie_salt)
    response = Client.find_by_email(email) or controller.not_found
    return nil if !response.is_a? Typhoeus
    user = response
    puts "authenticate_with_salt.user = #{user.to_s}"
    (user && user.salt == cookie_salt) ? user : nil
  end    
end
  
  
