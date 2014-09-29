module ResponseChecker
  class ContentTypeOptionsCheck
    def name
      'X-Content-Type-Options'
    end

    def description
    end

    def perform(_, response)
      'nosniff' == response['x-content-type-options']
    end
  end
end
