module ResponseChecker
  class FrameOptionsCheck
    def name
      'X-Frame-Options'
    end

    def description
    end

    def perform(_, response)
      return false if response['x-frame-options'].nil?
      Array(response.to_hash['x-frame-options']).all? { |x| %w(DENY SAMEORIGIN).include?(x.strip) }
    end
  end
end
