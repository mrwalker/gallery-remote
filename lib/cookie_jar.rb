# 
# cookie_jar.rb
# 
# Created on Sep 19, 2007, 7:39:33 PM
# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class CookieJar
  def initialize
    @cookies = []
  end
  
  def add(cookie_list)
    return if ! cookie_list
    cookie_list.each do |cookie_string|
      cookie = Cookie.new(cookie_string)
      @cookies = @cookies.reject {|c| c.name==cookie.name}
      @cookies << cookie
    end
  end
  
  def cookies
    return if @cookies.length == 0
    @cookies.map { |cookie| "#{cookie.name}=#{cookie.value}" }.join("; ")
  end
end

class Cookie
  attr_accessor :name, :value, :expiration
  
  def initialize(cookie_str)
    cookie_str.split(/;\s?/).each_with_index do |c,i|
      if i==0
        @name, *values = c.split("=")
        @value = values.join("=")
      end
    end
  end
end