# 
# gallery-remote.rb
# 
# Created on Sep 16, 2007, 4:16:42 PM
# 
require 'net/http'
require 'cookie_jar'

class GalleryRemote
  GR_STAT_SUCCESS=0
  PROTO_MAJ_VER_INVAL=101
  PROTO_MIN_VER_INVAL=102
  PROTO_VER_FMT_INVAL=103
  PROTO_VER_MISSING=104
  PASSWD_WRONG=201
  LOGIN_MISSING=202
  UNKNOWN_CMD=301
  NO_ADD_PERMISSION=401
  NO_FILENAME=402
  UPLOAD_PHOTO_FAIL=403
  NO_WRITE_PERMISSION=404
  NO_VIEW_PERMISSIO=405
  NO_CREATE_ALBUM_PERMISSION=501
  CREATE_ALBUM_FAILED=502
  MOVE_ALBUM_FAILED=503
  ROTATE_IMAGE_FAILED=504
  STATUS_DESCRIPTIONS = { 
          GR_STAT_SUCCESS=>"The command the client sent in the request completed successfully. The data (if any) in the response should be considered valid.",
          PROTO_MAJ_VER_INVAL=>"The protocol major version the client is using is not supported.",
          PROTO_MIN_VER_INVAL=>"The protocol minor version the client is using is not supported.",
          PROTO_VER_FMT_INVAL=>"The format of the protocol version string the client sent in the request is invalid.",
          PROTO_VER_MISSING=>"The request did not contain the required protocol_version key.",
          PASSWD_WRONG=>"The password and/or username the client send in the request is invalid.",
          LOGIN_MISSING=>"The client used the login command in the request but failed to include either the username or password (or both) in the request.",
          UNKNOWN_CMD=>"The value of the cmd key is not valid.",
          NO_ADD_PERMISSION=>"The user does not have permission to add an item to the gallery.",
          NO_FILENAME=>"No filename was specified.",
          UPLOAD_PHOTO_FAIL=>"The file was received, but could not be processed or added to the album.",
          NO_WRITE_PERMISSION=>"No write permission to destination album.",
          NO_VIEW_PERMISSIO=>"No view permission for this image.",
          NO_CREATE_ALBUM_PERMISSION=>"A new album could not be created because the user does not have permission to do so.",
          CREATE_ALBUM_FAILED=>"A new album could not be created, for a different reason (name conflict).",
          MOVE_ALBUM_FAILED=>"The album could not be moved.",
          ROTATE_IMAGE_FAILED=>"The image could not be rotated" 
    }          

  def initialize(url)
    @uri = URI.parse(url)
    @base_params = { 'g2_controller'=>'remote:GalleryRemote', 'g2_form[protocol_version]'=>'2.9' }
    @cookie_jar = CookieJar.new
  end

  def login(user, pass)
    send_request :cmd=>'login', :uname=>'carl', :password=>'yootgo'
  end

  def albums
    send_request :cmd=>'fetch-albums'
  end
  
  def status
    "#{@status} - (#{@status_text})"
  end
  
  private

  def send_request(params)
    result_hash = {}
    puts prep_params(params)
    req = Net::HTTP::Get.new "#{@uri.path}?#{prep_params params}", header
    res = Net::HTTP.new(@uri.host, @uri.port).start { |http| http.request(req) }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      read_cookies res.header
      result_hash = read_properties res.body
    else
      res.error!
    end
    @auth_token = result_hash['auth_token']
    @status = result_hash['status']
    @status_text = result_hash['status_text']
    result_hash
  end

  def header
    result = {}    
    result["Cookie"] = @cookie_jar.cookies if @cookie_jar.cookies
    result
  end
  
  def read_cookies header
    @cookie_jar.add(header.get_fields("set-cookie"))
  end

  def read_properties(lines)
    result = {}
    lines.each do |line|
      name, *values = line.strip.split(/\s*=\s*/)
      result[name.strip] = values.join "="
    end
    result
  end
  
  def prep_params(params)
    str = []
    @base_params.each_pair do |name, value|
      str << "#{name}=#{value}"
    end
    params.each_pair do |name, value|
      str << "g2_form[#{name}]=#{value}"
    end
    str << "g2_authToken=#{@auth_token}" if @auth_token
    str.join "&"
  end
end