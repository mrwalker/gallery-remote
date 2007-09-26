# 
# main.rb
# 
# Created on Sep 16, 2007, 4:28:41 PM
# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'gallery-remote'

r = GalleryRemote.new "http://www.leibys-place.com/gallery/main.php"
r.login "test_acct", "test"
puts r.status

r.albums(:cmd=>'fetch-albums-prune', :no_perms=>"y") do |album|
  puts album
end

#puts r.last_response.keys.join("\n")