require 'cookiejar'

module ResponseChecker
  class SecureCookieCheck
    def name
      'Secure cookie'
    end

    def description
    end

    def perform(_, response)
      return true if response['set-cookie'].nil?
      Array(response.to_hash['set-cookie']).all? { |c| c =~ /[sS]ecure/ }
    end
  end
end
