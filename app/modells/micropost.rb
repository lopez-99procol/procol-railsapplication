require_dependency 'client.rb'

class Micropost
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations
  
  ATTRIBUTES = [:id, :user_id, :content, :created_at, :updated_at]
  attr_accessor *ATTRIBUTES
  
  def initialize(attributes = {})
    self.attributes = attributes
  end
  
  def attributes
    instance_values
  end
  
  def attributes=(hash)
    hash.each do |key, value|
      puts "loading #{key} with #{value}"
      send("#{key}=", value) 
    end
  end
  
  def to_s
    self.to_json
  end

end