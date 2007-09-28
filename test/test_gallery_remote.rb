# 
# test_gallery_remote.rb
# 
# Created on Sep 26, 2007, 12:31:07 PM

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'gallery_remote'

class TestGalleryRemote < Test::Unit::TestCase
  def test_should_post_proper_login_credentials	
    flunk "TODO: Write test"
    r = GalleryRemote.new "http://www.leibys-place.com/gallery/main.php"
    r.login "test_acct", "test"    
  end
	
  def test_should_fail_with_exception_with_bad_login
  	flunk "TODO: Write test"    
  end
  
  def test_subsequent_call_should_post_auth_token
	flunk "TODO: Write test"
	r = GalleryRemote.new "http://www.leibys-place.com/gallery/main.php"
	r.login "test_acct", "test"
	r.albums
  end
end
