require 'json'
module ResponseChecker
  class JsonReporter
    def initialize(uri, results)
      @uri, @results = uri, results
    end

    def output
      JSON.generate(
        {
          @uri => { 'checks' => @results.map do |name, description, result|
              { 'name' => name, 'description' => description, 'result' => result }
            end
          }
        }
      )
    end
  end
end
