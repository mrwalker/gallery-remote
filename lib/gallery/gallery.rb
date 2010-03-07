module Gallery
  class Gallery
    attr_accessor :remote

    def initialize(url, &block)
      @remote = Remote.new(url)
      instance_eval(&block) if block_given?
    end

    def login(user, pass)
      @remote.login(user, pass)
    end

    def albums(params = {})
      response = @remote.fetch_albums_prune
      album_params = response.keys.inject([]) do |album_params, key|
        next album_params unless key =~ /album\.(.*)\.(\d+)/
        _, param, index = key.match(/album\.(.*)\.(\d+)/).to_a
        index = index.to_i
        album_params[index] ||= {}
        album_params[index][param] = response[key]
        album_params
      end.compact # Keys are 1-based; remove first element
      album_params.map do |params|
        album = Album.new(@remote, params)
        yield album if block_given?
        album
      end
    end
  end
end
