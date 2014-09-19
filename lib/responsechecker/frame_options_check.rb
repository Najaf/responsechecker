module ResponseChecker
  class FrameOptionsCheck
    def name
      'X-Frame-Options'
    end

    def description
    end

    def perform(_, response)
      %w(DENY SAMEORIGIN).include? response['x-frame-options'].to_s
    end
  end
end
