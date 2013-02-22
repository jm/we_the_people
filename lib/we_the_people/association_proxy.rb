module WeThePeople
  class AssociationProxy
    def initialize(parent, klass)
      @klass = klass
      @parent = parent
    end

    def find(id)
      @klass.find(id, @parent)
    end

    def cursor(criteria = {})
      @klass.cursor(@parent, criteria)
    end

    def all(criteria)
      cursor(criteria).all
    end
  end
end