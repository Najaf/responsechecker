class ResponseChecker::FrameOptionsCheck
  def name
    'X-Frame-Options'
  end

  def description
  end

  def perform(request, response)
    %w(DENY SAMEORIGIN).include? response['x-frame-options'].to_s
  end
end
