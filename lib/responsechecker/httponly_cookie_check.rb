require 'cookiejar'

module ResponseChecker
  class HttpOnlyCookieCheck
    def name
      'HttpOnly cookie'
    end

    def description
    end

    def perform(_, response)
      return true if response['set-cookie'].nil?
      Array(response.to_hash['set-cookie']).all? { |c| c.include?('HttpOnly') }
    end
  end
end
