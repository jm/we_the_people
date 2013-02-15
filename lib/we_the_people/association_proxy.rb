module WeThePeople
  class AssociationProxy
    def initialize(parent, klass)
      @klass = klass
      @parent = parent
    end

    def find(id)
      @klass.find(id, @parent)
    end

    def all(criteria = {})
      @klass.all(@parent, criteria)
    end
  end
end