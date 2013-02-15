module WeThePeople
  module Resources
    class User < WeThePeople::Resource
      attribute :created, Time
      has_embedded :location
    end
  end
end