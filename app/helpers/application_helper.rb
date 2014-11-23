module ApplicationHelper
  # Return a title on a per-page basis
  def title
    base_title = "Project-Collaboration"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def strip_params(params)
    puts "strip_params[#{params}]"
    if !params.nil?
      params.delete :utf8
      params.delete :authenticity_token
      params.delete :action
      params.delete :controller
      params.delete :commit
      params
    end
  end
end
