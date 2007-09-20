# 
# main.rb
# 
# Created on Sep 16, 2007, 4:28:41 PM
# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'gallery-remote'

r = GalleryRemote.new "http://www.leibys-place.com/gallery/main.php"
rslt = r.login "carl", "yootgo"
puts r.status
#puts rslt.inspect

rslt = r.albums
puts r.status

puts rslt.inspect