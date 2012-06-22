require 'lxc/client/request'
require 'lxc/client/request_methods'

module LXC
  class Client
    include LXC::Request
    include LXC::RequestMethods

    attr_reader :host, :port

    def initialize(host, port=5050)
      @host = host
      @port = port
    end
  end
end