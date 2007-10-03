# 
# main.rb
# 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'gallery_remote'

r = GalleryRemote.new "http://www.leibys-place.com/gallery/main.php"
r.login "test_acct", "test"
puts r.status

@test_album = nil
r.albums(:cmd=>'fetch-albums-prune', :no_perms=>"y") do |album|
  #puts album
  @test_album = album if album.title == "Test Account"
end

puts @test_album

r.add_item("test.jpg", @test_album.name)

#puts r.last_response.keys.join("\n")