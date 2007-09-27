# 
# cookie_jar_test.rb
# 
# Created on Sep 19, 2007, 7:34:55 PM

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'cookie_jar'
require 'yaml'

class TestCookieJar < Test::Unit::TestCase
  def setup
    @cookie_data = YAML::load( File.open( File.join(File.dirname(__FILE__),'cookies.yml') ) )
  end
  
  def test_should_handle_all_the_cookies_in_yaml_file
    assert @cookie_data, "Cookie data present"    
    @cookie_data.each do |k,v|
      cookie_jar = CookieJar.new
      cookie_jar.add(v['set-cookie'])
      assert_equal(v['result'], cookie_jar.cookies)
    end
  end
  
  def test_should_return_nil_ginen_nil_cookie_string
    cookie_jar = CookieJar.new
    cookie_jar.add(nil)
    assert_nil cookie_jar.cookies
  end
  
  def test_should_ignore_expired_cookies
    cookie_jar = CookieJar.new
    cookie_jar.add(["COOKIE_ID=SDFW234GAE234SERG; expires=Sun, 13-Sep-1950 18:31:46 GMT"])
    assert_nil cookie_jar.cookies    
  end
end
