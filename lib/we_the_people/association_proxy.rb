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

    def get_all
      cursor.get_all(false)
    end

    def all
      cursor.all
    end

    def length
      cursor.length
    end

    def first
      cursor.first
    end
  end
end