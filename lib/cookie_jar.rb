# 
# cookie_jar.rb
# 
# Created on Sep 19, 2007, 7:39:33 PM
require 'date'

class CookieJar
  def initialize
    @cookies = []
  end
  
  def add(cookie_list)
    return if ! cookie_list
    cookie_list.each do |cookie_string|
      cookie = Cookie.new(cookie_string)
      if ! cookie.expired
        @cookies = @cookies.reject {|c| c.name==cookie.name}
        @cookies << cookie
      end
    end
  end
  
  def cookies
    return if @cookies.length == 0
    @cookies.map { |cookie| cookie.to_s }.join("; ")
  end
end

class Cookie
  attr_accessor :name, :value, :expiration
  
  def initialize(cookie_str)
    cookie_str.split(/;\s?/).each_with_index do |c,i|
      if i==0
        @name, *values = c.split("=")
        @value = values.join("=")
      else
        attr_name, *attr_values = c.split("=")
        attr_value = attr_values.join("=")
        if attr_name =~ /expires/i
          @expiration = attr_value
        end
      end
    end
  end
  
  def to_s
    "#{@name}=#{@value}"
  end
  
  def expired
    if @expiration
      @expiration.sub!(/^([a-zA-Z]+,)(\d)/) { |s| "#{$1} #{$2}" }
      expiration_date = DateTime.parse( @expiration, true )
      return expiration_date < DateTime.now    
    end
    false
  end
end