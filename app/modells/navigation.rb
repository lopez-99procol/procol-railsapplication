require_dependency 'client.rb'

class Navigation 
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations
  
  ATTRIBUTES = [:id, :label, :link, :free]
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