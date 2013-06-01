## This is the rakegem gemspec template. Make sure you read and understand
## all of the comments. Some sections require modification, and others can
## be deleted if you don't need them. Once you understand the contents of
## this file, feel free to delete any comments that begin with two hash marks.
## You can find comprehensive Gem::Specification documentation, at
## http://docs.rubygems.org/read/chapter/20
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'we_the_people'
  s.version           = '0.0.6'
  s.date              = '2013-06-01'
  s.rubyforge_project = 'we_the_people'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "API client for We The People."
  s.description = "API client for the We The People petition application."

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Jeremy McAnally"]
  s.email    = 'jeremy@github.com'
  s.homepage = 'http://github.com/jm/we_the_people'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  s.add_dependency('rest-client')
  s.add_dependency('json')
  s.add_dependency('activesupport', '>= 3.0.0')
  
  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    Gemfile.lock
    LICENSE
    README.md
    Rakefile
    lib/we_the_people.rb
    lib/we_the_people/association_proxy.rb
    lib/we_the_people/collection.rb
    lib/we_the_people/config.rb
    lib/we_the_people/embedded_resource.rb
    lib/we_the_people/resource.rb
    lib/we_the_people/resources/issue.rb
    lib/we_the_people/resources/location.rb
    lib/we_the_people/resources/petition.rb
    lib/we_the_people/resources/response.rb
    lib/we_the_people/resources/signature.rb
    lib/we_the_people/resources/user.rb
    lib/we_the_people/simple.rb
    we_the_people.gemspec
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
