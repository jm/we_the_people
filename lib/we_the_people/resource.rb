module WeThePeople
  class Resource
    class <<self
      attr_reader :embedded_attributes, :embedded_array_attributes, :attributes

      def bare_name
        name.split("::").last
      end

      def find(id, parent = nil)
        raise "Must be called by parent." if @belongs_to && parent.nil?

        json = WeThePeople::Config.client.get(build_resource_url(id, parent), :params => WeThePeople::Config.default_params).to_s
        new(WeThePeople::Config.json.parse(json)['results'].first)
      end

      def path(parent = nil)
        raise "Must be called by parent." if @belongs_to && parent.nil?

        if parent
          "#{parent.path}/#{bare_name.underscore.pluralize}"
        else
          "#{bare_name.underscore.pluralize}"
        end
      end

      def build_resource_url(id, parent = nil)
        "#{WeThePeople::Config.host}/#{path(parent)}/#{id}.json"
      end

      def fetch(parent = nil, criteria = {})
        raise "Must be called by parent." if @belongs_to && parent.nil?

        body = WeThePeople::Config.client.get(build_index_url(parent, criteria), :params => criteria.merge(WeThePeople::Config.default_params)).to_s
        WeThePeople::Config.json.parse(body)
      end

      def cursor(parent = nil, criteria = {})
        Collection.new(self, criteria, fetch(parent, criteria), parent)
      end

      def all(parent = nil, criteria = {})
        cursor(parent, criteria).all
      end

      def build_index_url(parent = nil, criteria = {})
        "#{WeThePeople::Config.host}/#{path(parent)}.json"
      end

      def belongs_to(klass_name)
        @belongs_to = klass_name

        define_method klass_name.to_s.downcase do
          @parent
        end
      end

      def add_attribute_key(key)
        @attributes ||= []
        @attributes << key.to_s
      end

      COERCERS = {
        Integer => lambda {|v| Integer(v) },
        Time => lambda {|v| Time.at(v) }
      }

      def coerce_value(val, klass)
        COERCERS[klass].call(val)
      end

      def attribute(name, coerce_to = nil, key_name = nil)
        name = name.to_s
        key_name ||= name
        add_attribute_key(key_name)

        define_method "#{name}=" do |val|
          val = self.class.coerce_value(val, coerce_to) if coerce_to
          @attributes[key_name] = val
        end

        define_method name do
          coerce_to ? self.class.coerce_value(@attributes[key_name], coerce_to) : @attributes[key_name]
        end
      end

      def has_embedded(klass_name)
        name = klass_name.to_s.singularize

        add_attribute_key(name)
        @embedded_attributes ||= []
        @embedded_attributes << name

        define_method "#{name}=" do |val|
          val = klass.new(val)
          @attributes[name] = val
        end

        define_method name do
          @attributes[name]
        end
      end

      def has_many_embedded(klass_name)
        name = klass_name.to_s.pluralize

        add_attribute_key(name)
        @embedded_array_attributes ||= []
        @embedded_array_attributes << name

        define_method "#{name}=" do |val|
          raise TypeError unless val.is_a?(Array)

          val = val.map {|o| klass.new(o)}
          @attributes[name] = val
        end

        define_method name do
          @attributes[name]
        end
      end

      def has_many(klass_name)
        name = klass_name.to_s.pluralize

        add_attribute_key(name)

        define_method name do
          AssociationProxy.new(self, "WeThePeople::Resources::#{name.classify}".constantize)
        end
      end
    end

    def initialize(attrs, parent = nil)
      @parent = parent

      result = {}
      attrs.each_pair do |key, value|
        result[key.to_s.gsub(/\s/, '_')] = value
      end
      
      attrs = result.select {|a| self.class.attributes.include?(a)}

      self.class.embedded_attributes.each do |embedded_key|
        attrs[embedded_key] = "WeThePeople::Resources::#{embedded_key.classify}".constantize.new(attrs[embedded_key]) if !attrs[embedded_key].nil? && !attrs[embedded_key].empty?
      end if self.class.embedded_attributes

      self.class.embedded_array_attributes.each do |embedded_array_key|
        if attrs[embedded_array_key].is_a?(Array)
          # NOTE: This is to make RubyMotion happy
          attrs[embedded_array_key] = attrs[embedded_array_key].dup
          attrs[embedded_array_key].map! do |embedded_array_element|
            "WeThePeople::Resources::#{embedded_array_key.classify}".constantize.new(embedded_array_element)
          end
        end
      end if self.class.embedded_array_attributes

      @attributes = attrs
    end

    def path
      "#{self.class.path}/#{id}"
    end

    def to_json
      @attributes.to_json
    end
  end
end