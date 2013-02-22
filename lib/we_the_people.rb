$:.unshift(File.dirname(__FILE__))

require 'json'
require 'rest_client'
require 'active_support/inflector'
require 'active_support/core_ext/hash'

require 'we_the_people/resource'
require 'we_the_people/embedded_resource'
require 'we_the_people/association_proxy'
require 'we_the_people/collection'

require 'we_the_people/resources/petition'
require 'we_the_people/resources/issue'
require 'we_the_people/resources/response'
require 'we_the_people/resources/signature'
require 'we_the_people/resources/location'
require 'we_the_people/resources/user'

module WeThePeople
  VERSION = '0.0.1'

  class <<self
    attr_writer :default_page_size
    def default_page_size
      @default_page_size ||= 1000
    end

    attr_writer :client
    def client
      @client ||= RestClient
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