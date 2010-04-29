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
    filter_request!
    @application.call(@environment)
  end

  private

  def filter_request!
    @environment["rack.request.form_hash"]  = SqlInjectionFilter.new(@environment["rack.request.form_hash"]).sanitize 
    @environment["rack.request.form_hash"]  = NullByteInjectionFilter.new(@environment["rack.request.form_hash"]).sanitize 
  end

end

