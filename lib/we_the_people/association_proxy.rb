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

    delegate :all, :length, :first, :to => :cursor
  end
end