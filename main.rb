#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'yaml'
require 'gallery'

PARENT = 'Gallery'
TEST_ALBUM = 'Test Album'
TEST_IMAGE = 'Hurt Whale'
account = YAML.load_file('account.yml')

Gallery::Gallery.new(account[:url]) do
  login account[:username], account[:password]

  album_cache = albums
  parent_album = album_cache.find{ |a| a.title == PARENT }
  raise 'Parent album not found; please create it or specify a new one' unless parent_album

  test_album = album_cache.find{ |a| a.title == TEST_ALBUM }
  unless test_album
    puts "Album missing: #{TEST_ALBUM}"
    parent_album.add_album TEST_ALBUM
    raise 'Failed to create album' unless remote.status == Gallery::Remote::GR_STAT_SUCCESS

    album_cache = albums
    test_album = album_cache.find{ |a| a.title == TEST_ALBUM }
    raise 'Failed to create album' unless test_album
  end

  image_cache = test_album.images
  test_image = image_cache.find{ |i| i.caption == TEST_IMAGE }
  unless test_image
    puts "Image missing: #{TEST_IMAGE}"
    test_album.add_item 'whale.jpg', :caption => TEST_IMAGE, :'extrafield.Description' => 'This is a cartoon of an injured whale'
    raise 'Failed to add image' unless remote.status == Gallery::Remote::GR_STAT_SUCCESS

    image_cache = test_album.images
    test_image = image_cache.find{ |i| i.caption == TEST_IMAGE }
    raise 'Failed to add image' unless test_image
  end
end
