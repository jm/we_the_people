module WeThePeople
  class Simple
    class <<self
      def petitions(criteria = {})
        get("petitions.json", criteria)
      end

      def petition(id)
        get("petitions/#{id}.json").first
      end

      def signatures(petition_id, criteria = {})
        get("petitions/#{petition_id}/signatures.json", criteria)
      end

      def signature(petition_id, signature_id)
        get("petitions/#{petition_id}/signatures/#{signature_id}.json").first
      end

      def users(criteria = {})
        get("users.json", criteria)
      end

      def user(id)
        get("users/#{id}.json").first
      end

      def url(path)
        "#{WeThePeople::Config.host}/#{path}"
      end

      def get(path, params = {})
        response = WeThePeople::Config.client.get(url(path), :params => params.merge(WeThePeople::Config.default_params))
        WeThePeople::Config.json.parse(response.body)['results']
      end
    end
  end
end