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
      @cursor ||= @klass.cursor(@parent, criteria)
    end

    def all
      cursor.all(refresh = false)
    end

    def length
      cursor.length
    end

    def first
      cursor.first
    end
  end
end