class EmbeddedResourceObject < Struct
  def self.hash_initialized(*keys)
    klass = Class.new(self.new(*keys))
    keys = keys.map(&:to_s)

    klass.class_eval do
      define_method(:initialize) do |h|
        super(*h.values_at(*keys))
      end
    end
    
    klass
  end

  def to_json(_)
    Hash[self.each_pair.to_a].to_json
  end
end

def EmbeddedResource(*keys)
  EmbeddedResourceObject.hash_initialized(*keys)
end
