require_dependency 'client.rb'

class Userprofile
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :renewaldate
  
  def initialize
    super
    @navigation_ids = []
    puts "initalize Userprofile with #{@navigation_ids}"
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
  
  def to_s
    self.to_json
  end
  
  def navigation
    @navigation_ids
  end
  
  def navigation_id=(navigation)
    @navigation_ids.push(navigation)
  end
end