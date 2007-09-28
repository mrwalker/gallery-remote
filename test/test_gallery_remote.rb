# 
# test_gallery_remote.rb
# 
# Created on Sep 26, 2007, 12:31:07 PM

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'gallery_remote'
require 'mocha'
require 'net/http'

class TestGalleryRemote < Test::Unit::TestCase
  def test_should_post_proper_login_credentials	
    r = GalleryRemote.new "http://www.leibys-place.com/gallery/main.php"

	#setup mocks and expectations
  	response = Net::HTTPSuccess.new('1.2', '200', 'OK')
    header = mock()
    header.expects(:get_fields).returns(nil)
    r.stubs(:post).with(regexp_matches(/g2_form\[uname\]=test_acct/), {}).returns(response)
    response.expects(:header).returns(header)
    response.expects(:body).returns("")
    
    #test
    r.login "test_acct", "test"    
  end
	
end
