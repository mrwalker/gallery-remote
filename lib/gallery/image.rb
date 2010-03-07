module Gallery
  class Image
    attr_accessor :remote, :params

    def initialize(remote, params = {})
      @remote, @params = remote, params
    end

    def properties(params = {})
      @remote.image_properites(name, params)
    end

    def name
      @params['name']
    end

    def title
      @params['title']
    end

    def caption
      @params['caption']
    end

    def to_s
      "Image #{name}: #{title}"
    end
  end
end
