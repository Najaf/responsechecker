module ResponseChecker
  class XssProtectionCheck
    def name
      'X-XSS-Protection'
    end

    def description
    end

    def perform(_, response)
      '1; mode=block' == response['x-xss-protection']
    end
  end
end
