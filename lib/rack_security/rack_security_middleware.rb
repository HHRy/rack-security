require 'rack'
require 'rack/request'
require 'rack/response'
require 'rack/utils'

class RackSecurityMiddleware

  def initialize(rack_application)
    @application = rack_application    
  end 

  def call(environment)
    @environment = environment
     
    if @environment['CONTENT_TYPE'] =~ /(.*)boundary=(.*)/
      @boundary = $2
    end    

    new_body = @environment['rack.input'].read

    if @boundary 
      parts = new_body.split(@boundary)
      parts.each_with_index do |content, index|
        parts[index] = the_correct_hasher_for(content[0,10]).new(content).hash
      end
      new_body = parts.join(@boundary)
      new_content_length = new_body.length
    else
      new_body = the_correct_hasher_for(new_body[0,10]).new(new_body).hash
      new_content_length = new_body.length
    end 

    new_body = StringIO.new(new_body)
    new_body.rewind
    @environment['CONTENT_LENGTH'] = new_content_length
    @environment['rack.input'] = new_body

    rebuild_environment!
    @application.call(@environment)
  end 

  private

  def rebuild_environment!
    @environment['rack.request.form_input'] = @environment['rack.input']
    if @boundary
      @environment["rack.request.form_hash"] = Rack::Utils::Multipart.parse_multipart(@environment)
    else
      form_vars = @environment["rack.input"].read
      form_vars.sub!(/\0\z/, '')
      @environment["rack.request.form_vars"] = form_vars
      @environment["rack.request.form_hash"] = Rack::Utils.parse_nested_query(form_vars)
      @environment["rack.input"].rewind
    end
  end

end

