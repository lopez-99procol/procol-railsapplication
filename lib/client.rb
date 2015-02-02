require 'typhoeus'
require 'json'

class Client
  # Class level
  class << self; attr_accessor :base_uri, :user end

  def self.find(id)
    request = "#{base_uri}/api/v1/users/#{id}"
      do_request(request, 'get', nil, "load_user")
  end

  def self.find_by_name(name)
    request = "#{base_uri}/api/v1/users/name/#{name}"
    self.do_request(request, 'get', nil, "load_user")
  end

  def self.find_by_email(email)
    email = CGI::escape(email)
    request = "#{base_uri}/api/v1/users/email/#{email}"
    puts "find_by_email.request => #{request}"
    self.do_request(request, 'get', nil, "load_user")
  end
  
  def self.get_navigation(user_id)
    request = "#{base_uri}/api/v1/users/#{user_id}/navigation"
    puts "get_navigation.request => #{request}"
    self.do_request(request, 'get', nil, "load_navigation")
  end

  def self.create(attributes)
    request = "#{base_uri}/api/v1/users"
    do_request(request, 'post', attributes, "load_user")
  end
  
  def self.create_navigation(attributes)
    request = "#{base_uri}/api/v1/users/navigation"
    do_request(request, 'post', attributes, nil) #"load_navigation" - JSON Parser Error
  end
  
  def self.update(id, attributes)
    request = "#{base_uri}/api/v1/users/#{id}"
    do_request(request, 'put', attributes, "load_user")
  end

  def self.destroy(id)
    request = "#{base_uri}/api/v1/users/#{id}"
    do_request(request, 'delete', nil, "load_user")
  end
  
  def self.signin(email, attributes)
    email = CGI::escape(email)
    request = "#{base_uri}/api/v1/users/#{email}/sessions"
    do_request(request, 'post', attributes, "load_user")
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
    #puts "hash: #{rb_hash}"
    
    # Put the hash back to json string format
    json_data = rb_hash.to_json
    
    user.from_json(json_data)
    #puts "user.to_s = #{user.to_s}"
    @user = user
    user
  end
  
  def self.load_navigation(response_body)
    navigations = []
    
    puts "rb: #{response_body}"
    
    # Transform to JSON     
    rb_hash = JSON.parse(response_body)
    
    # Print JSON result
    rb_hash.each do |pair| 
    
      # Modify JSON Hash
      #rb_hash.delete("created_at")
      #rb_hash.delete("updated_at")
    
      puts
      puts "load_navigation pair[#{pair}]"
    
      # Put the hash back to json string format
      json_data = pair.to_json
    
      #puts "user.to_s = #{user.to_s}"
      navigations.push(Navigation.new().from_json(json_data))
    end
    navigations
  end
  
  # do_request makes the request and the response handling against the sinatrausers-webservice
  def self.do_request(requesturl, verb, attributes, method)
    debug = "do_request->"
    user = nil
    json_attributes = !attributes.nil? ? attributes.to_json  : nil
    puts "do request[#{requesturl}] for verb[#{verb}] with attributes[#{json_attributes}] "
    case verb
    when 'get'
      response = Typhoeus::Request.get(requesturl)
    when 'post'
      response = Typhoeus::Request.post(requesturl, :body => json_attributes)
    when 'delete'
      response = Typhoeus::Request.delete(requesturl)
    when 'put'
      response = Typhoeus::Request.put(requesturl, :body => json_attributes)
    else
      response = nil
    end
    
    if !response.nil?
      case response.code
      when 200
        json_hash = response.body
        puts debug+"json_hash(#{json_hash}), [response.code]= #{response.code}"
        puts debug+"json_attributes(#{json_attributes})"
        #return self.method(method).call(json_hash)
        return self.method(method).call(json_hash) if !method.nil?
      when 404
        raise ArgumentError, "Wrong arguments! #{response.body}", caller
      else
        raise RuntimeError, "Unknown error! #{response.body}", caller
      end
    end
    user
  end
end