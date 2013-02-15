class Struct
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
end

def EmbeddedResource(*keys)
  Struct.hash_initialized(*keys)
end
