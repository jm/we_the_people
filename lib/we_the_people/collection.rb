module WeThePeople
  class Collection
    include Enumerable
    attr_reader :count, :offset, :limit, :all

    def initialize(klass, conditions, hash)
      @criteria = conditions

      if hash['metadata']['resultset']
        @count = hash['metadata']['resultset']['count'].to_i
        @offset = hash['metadata']['resultset']['offset'].to_i
        @limit = hash['metadata']['resultset']['limit'].to_i
      else
        @count = WeThePeople.default_page_size
        @offset = 0
        @limit = WeThePeople.default_page_size
      end
      
      @klass = klass

      process_results(hash['results'])
    end

    def process_results(results)
      @all = results.map do |result|
        @klass.new(result)
      end
    end

    def next_page
      @offset += @limit
      get_all
    end

    def get_all
      @klass.all(@parent, @criteria.merge(:offset => @offset, :limit => @limit))
    end

    def previous_page
      @offset -= @limit
      @offset = 0 if @offset < 0

      get_all
    end

    def each
      @all.each do |record|
        yield record
      end
    end
  end
end