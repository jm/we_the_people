module WeThePeople
  module Resources
    class Petition < WeThePeople::Resource
      attribute :id
      attribute :type
      attribute :title
      attribute :body
      attribute :status
      attribute :url
      attribute :signature_threshold, Integer, 'signatureThreshold'
      attribute :signature_count, Integer, 'signatureCount'
      attribute :signatures_needed, Integer, 'signaturesNeeded'
      attribute :deadline, Time
      attribute :created, Time

      has_embedded :response
      has_many_embedded :issues

      has_many :signatures

      def successful?
        signatures_needed == 0
      end

      def failed?
        expired? && !successful?
      end

      def signatures_needed?
        signatures_needed > 0
      end

      def response?
        !response.nil?
      end

      def expired?
        deadline < Time.now
      end
    end
  end
end