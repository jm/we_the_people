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
        url_string = ("http://myapp.com/api.json").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        url = NSURL.URLWithString(url_string)
        request = NSURLRequest.requestWithURL(url)
        response = nil
        error = nil
        data = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        raise "BOOM!" unless (data.length > 0 && error.nil?)
        json = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
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
        in_motion? ? BW::JSON : JSON
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

        params
      end

      attr_accessor :mock
    end
  end
end