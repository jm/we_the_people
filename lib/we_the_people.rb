$:.unshift(File.dirname(__FILE__))

require 'json'
require 'rest_client'
require 'active_support/inflector'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/module/delegation'

require 'we_the_people/config'
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

if defined?(Motion::Project::Config)  
  Motion::Project::App.setup do |app|
    # Borrowed from the teacup gem
    insert_point = 0
    app.files.each_index do |index|
      file = app.files[index]
      if file =~ /^(?:\.\/)?app\//
        # found app/, so stop looking
        break
      end
      insert_point = index + 1
    end

    Dir.glob(File.join(File.dirname(__FILE__), 'we_the_people/**/*.rb')).reverse.each do |file|
      app.files.insert(insert_point, file)
    end
  end
end

module WeThePeople
  VERSION = '0.0.2'
end