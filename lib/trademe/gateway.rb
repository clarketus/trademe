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
        params.map{|k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join("&")
      end

      def send_request(path)        
        json = if !authorized?        
          uri = URI.parse("#{protocol}://#{@domain}")
          Net::HTTP.get uri.host, path
        else
          res = consumer.request(:get, ("#{protocol}://#{@domain}" + path), access_token, { :scheme => :query_string })
          res.body
        end
                
        ::Yajl::Parser.new.parse json
      rescue ::Yajl::ParseError
        nil
      end

      def protocol
        authorized? ? "https" : "http"
      end

      def base_url
        "/#{@version}"
      end
    
  end
end