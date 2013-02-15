module WeThePeople
  module Resources
    class Signature < WeThePeople::Resource
      belongs_to :petition

      attribute :id
      attribute :name
      attribute :city
      attribute :state
      attribute :zip
      attribute :created
    end
  end
end