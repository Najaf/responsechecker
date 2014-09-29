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
      request, response = nil, nil

      Net::HTTP.start(uri.host, uri.port) do |http|
        request  = Net::HTTP::Get.new(uri)
        response = http.request request
      end

      
      @checks.map do |check|
        [check.name, check.description, check.perform(request, response)]
      end
    end
  end
end
