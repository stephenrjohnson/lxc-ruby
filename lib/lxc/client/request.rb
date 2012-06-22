require 'faraday'
require 'faraday_middleware'

module LXC
  module Request
    def connection(url)
      connection = Faraday.new(url) do |c|
        c.use(Faraday::Request::UrlEncoded)
        c.use(Faraday::Response::ParseJson)
        c.adapter(Faraday.default_adapter)
      end
    end

    def request(method, path, params={}, raw=false)
      url = "http://#{host}:#{port}"
      headers = {'Accept' => 'application/json'}

      response = connection(url).send(method) do |request|
        case method
          when :delete, :get
            request.url(path, params)
          when :post, :put
            request.path = path
            request.body = params unless params.empty?
        end
      end
      raw ? response : response.body
    end
  end
end