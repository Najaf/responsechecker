module ResponseChecker
  class StrictTransportSecurityCheck
    def name
      'Strict transport security'
    end

    def description
    end

    def perform(_, response)
      !!(response['strict-transport-security'] =~ /^max-age=\d+$/)
    end
  end
end
