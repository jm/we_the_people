module WeThePeople
  module Resources
    class Petition < WeThePeople::Resource
      attribute :id
      attribute :type
      attribute :title
      attribute :body
      attribute :status
      attribute :signature_threshold, Integer
      attribute :signature_count, Integer
      attribute :signatures_needed, Integer
      attribute :deadline, Integer
      attribute :created, Time

      has_embedded :response
      has_many_embedded :issues

      has_many :signatures
    end
  end
end