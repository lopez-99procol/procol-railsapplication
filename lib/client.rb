require 'typhoeus'
require 'json'

class Client
  # Class level
  class << self; attr_accessor :base_uri, :user end

  def self.find(id)
    request = "#{base_uri}/api/v1/users/#{id}"
    puts "find.request => #{request}"
    response = Typhoeus::Request.get(request)
    if response.code == 200
      json_hash = response.body
      return load_user(json_hash)
    elsif response.code == 404
      nil
    else
      raise response.body
    end
    response
  end

  def self.find_by_name(name)
    request = "#{base_uri}/api/v1/users/name/#{name}"
    response = Typhoeus::Request.get(request)
    if response.code == 200
      json_hash = response.body
      return load_user(json_hash)
    elsif response.code == 404
      nil
    else
      raise response.body
    end
    response
  end

  def self.find_by_email(email)
    email = CGI::escape(email)
    request = "#{base_uri}/api/v1/users/email/#{email}"
    puts "find_by_email.request => #{request}"
    response = Typhoeus::Request.get("#{base_uri}/api/v1/users/email/#{email}")
    puts "find_by_mail.response => #{response}, [response.code]= #{response.code}"
    if response.code == 200
      json_hash = response.body
      return load_user(json_hash)
    elsif response.code == 404
      nil
    else
      raise response.body
    end
    response
  end

  def self.create attributes
    body = attributes.to_json
    puts "create.body= #{body}"
    request = "#{base_uri}/api/v1/users"
    puts "create.request => #{request}"
    response = Typhoeus::Request.post(request, :body => body)
    if response.code == 200
      json_hash = response.body
      return load_user(json_hash)
    elsif response.code == 400
      nil
    else
      raise response.body
    end
    response
  end

  def self.update(name, attributes)
    response = Typhoeus::Request.put("#{base_uri}/api/v1/users/name/#{name}", :body => attributes.to_json)
    if response.code == 200
      JSON.parse(response.body)
    elsif response.code == 400 || response.code == 404
      nil
    else
      raise response.body
    end
    response
  end
  
  def self.update(id, attributes)
    response = Typhoeus::Request.put("#{base_uri}/api/v1/users/#{id}", :body => attributes.to_json)
    if response.code == 200
      JSON.parse(response.body)
    elsif response.code == 400 || response.code == 404
      nil
    else
      raise response.body
    end
    response
  end

  def self.destroy(name)
    response = Typhoeus::Request.delete("#{base_uri}/api/v1/users/name/#{name}")
    response # response.code == 200
  end
  
  def self.signin(email, password)
    response = Typhoeus::Request.post("#{base_uri}/api/v1/users/#{email}/sessions", :body => {:email => email, :password => password}.to_json)
    if response.success? # response.code == 200
      JSON.parse(response.body)
    elsif response.code == 400
      nil
    else
      raise response.body
    end
    response
  end
  
  def self.load_user(response_body)
    user = User.new
    
    puts "rb: #{response_body}"
    
    # Transform to JSON     
    rb_hash = JSON.parse(response_body)
    
    # Print JSON result
    rb_hash.each { |pair| print pair}
    
    # Modify JSON Hash
    rb_hash.delete("created_at")
    rb_hash.delete("updated_at")
    
    puts
    puts "hash: #{rb_hash}"
    
    # Put the hash back to json string format
    json_data = rb_hash.to_json
    
    user.from_json(json_data)
    puts "user.to_s = #{user.to_s}"
    @@user = user
    user
  end
end