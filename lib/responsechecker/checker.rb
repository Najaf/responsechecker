require 'net/http'
require 'uri'
module ResponseChecker
  class Checker
    attr_reader :url

    def initialize(url)
      @url = url
      @checks = []
    end

    def <<(check)
      @checks << check
    end

    def perform_checks
      uri = URI(@url)

      request  = Net::HTTP::Get.new(uri)
      response = get_with_redirects(uri)

      @checks.map do |check|
        [check.name, check.description, check.perform(request, response)]
      end
    end

    def self.new_with_all_checks(url)
      self.new(url).tap do |c|
        c << ContentTypeOptionsCheck.new
        c << FrameOptionsCheck.new
        c << HttpOnlyCookieCheck.new
        c << SecureCookieCheck.new
        c << StrictTransportSecurityCheck.new
        c << XssProtectionCheck.new
      end
    end
  private

    def get_with_redirects(uri)
      response = Net::HTTP.get_response(uri)

      if '301' == response.code
        response = get_with_redirects(URI.parse(response['location']))
      end

      response
    end
  end
end
