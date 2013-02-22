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
      attribute :deadline, Time
      attribute :created, Time

      has_embedded :response
      has_many_embedded :issues

      has_many :signatures

      def successful?
        signatures_needed == 0
      end

      def failed?
        deadline < Time.now && !successful?
      end
    end
  end
end