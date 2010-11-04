module Trademe
  class Gateway
    
    DOMAIN = "api.trademe.co.nz"
    VERSION = "v1"
    FORMAT = "json"
    
    include Authentication
    
    def initialize(opts={})
      @domain = opts[:domain] || DOMAIN
      @version = opts[:version] || VERSION
      @format = FORMAT # format must be json
    end
    
    def search(term, filters = {})
      term = term.split("/").map{|t| t.capitalize }.join("/")

      url = "#{base_url}/Search/#{term}.#{@format}"
      url << "?#{urlize(filters)}" unless filters.empty?

      response = send_request(url)
      response["List"].map{|hash| Models::Listing.new(hash) } if response["List"]
    end
    
    private
    
      def urlize(params)
        params.map{|k,v|
          value = if v.respond_to?(:utc) && v.respond_to?(:strftime)
            ms = v.utc.usec.to_s[0..1].to_i # probably a better way to do this
            v.utc.strftime("%Y-%m-%dT%H:%M:%S.#{ms}Z") # time format trademe API accepts
          else
            v.to_s
          end
        
          "#{k}=#{CGI::escape(value)}"
        }.join("&")
      end

      def send_request(path)        
        response = if !authorized?        
          uri = URI.parse("#{protocol}://#{@domain}")
          Net::HTTP.get uri.host, path
        else
          res = consumer.request(:get, ("#{protocol}://#{@domain}" + path), access_token, { :scheme => :query_string })
          res.body
        end
                
        json = ::Yajl::Parser.new.parse(response)
        raise ApiError.new "#{json["ErrorDescription"]}" if json["ErrorDescription"]
        json
      rescue ::Yajl::ParseError => e
        raise ApiError.new "Bad JSON response #{response.inspect}"
      end

      def protocol
        authorized? ? "https" : "http"
      end

      def base_url
        "/#{@version}"
      end
    
  end
  
  class ApiError < StandardError; end
end