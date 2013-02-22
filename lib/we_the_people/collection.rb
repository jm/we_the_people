module WeThePeople
  class Collection
    include Enumerable
    attr_reader :count, :offset, :limit, :current_page, :all

    def initialize(klass, conditions, hash, parent = nil)
      @criteria = conditions
      @parent = parent
      
      if hash['metadata']['resultset']
        @count = hash['metadata']['resultset']['count'].to_i
        @offset = hash['metadata']['resultset']['offset'].to_i
        @limit = hash['metadata']['resultset']['limit'].to_i
      else
        @count = WeThePeople::Config.default_page_size
        @offset = 0
        @limit = WeThePeople::Config.default_page_size
      end

      @klass = klass

      @all = []
      process_results(hash['results'])
    end

    def next_page
      @offset += @limit unless @all.empty?

      fetch_current_page
      @current_page
    end

    def fetch_current_page
      fetch_page(@offset, @limit)
    end

    def previous_page
      @offset -= @limit
      @offset = 0 if @offset < 0

      @all.slice(@offset, @limit)
    end

    def get_all(refresh = false)
      if refresh 
        @all = []
        @offset = 0
      end

      (@offset..@count).step(@limit) do |current_offset|
        @all += fetch_page(current_offset, @limit)
      end

      @all
    end

    def length
      @count
    end
    alias size length

    def page_length
      @limit
    end
    alias page_size page_length

    def each
      @all.each do |record|
        yield record
      end
    end
  private
    def fetch_page(page_offset, page_limit)
      process_results(@klass.fetch(@parent, @criteria.merge(:offset => page_offset, :limit => page_limit))['results'])
    end

    def process_results(results)
      @current_page = results.map do |result|
        @klass.new(result)
      end

      @all += @current_page
    end
  end
end