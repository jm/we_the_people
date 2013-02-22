module WeThePeople
  class Config
    class MotionHTTPWrapper
      class Response
        attr_reader :body
        def initialize(response_body)
          @body = response_body
        end
      end

      def self.get(url, args = {})
        url_string = ("#{url}?#{make_query_string(args[:params] || {})}").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        url = NSURL.URLWithString(url_string)
        request = NSURLRequest.requestWithURL(url)
        response = nil
        error = nil
        data = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        
        NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
      end

      def self.make_query_string(hash)
        hash.collect do |key, value|
          "#{key}=#{value}"
        end.sort * '&'
      end
    end

    class MotionJSONWrapper
      def self.parse(string_data)
        json_data = string_data.dataUsingEncoding(NSUTF8StringEncoding)
        e = Pointer.new(:object)
        NSJSONSerialization.JSONObjectWithData(json_data, options:0, error: e).mutableCopy
      end
    end

    class <<self
      attr_writer :default_page_size
      def default_page_size
        @default_page_size ||= 1000
      end

      attr_writer :client
      def client
        @client ||= (in_motion? ? MotionHTTPWrapper : RestClient)
      end

      def json
        in_motion? ? MotionJSONWrapper : JSON
      end

      def in_motion?
        defined?(BW)
      end

      def host
        "http://petitions.whitehouse.gov/api/v1"
      end

      attr_accessor :api_key

      def default_params
        raise "Set your API key!" unless @api_key
        params = { :key => @api_key }
        params.merge!(:mock => 1) if @mock
        params.merge!(:limit => default_page_size)
        params
      end

      attr_accessor :mock
    end
  end
end