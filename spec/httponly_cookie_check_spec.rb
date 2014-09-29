require 'spec_helper'
require 'ostruct'

RSpec.describe HttpOnlyCookieCheck do
  let(:check)     { HttpOnlyCookieCheck.new }
  let(:request)   { OpenStruct.new(uri: 'https://example.com/') }
  let(:no_cookie_response) { {} }

  let(:non_httponly_cookie_string)     { 'foo=bar; path=/; Secure' }
  let(:httponly_cookie_string)         { 'bar=baz; path=/; HttpOnly'   }
  let(:another_httponly_cookie_string) { 'bish=bash; path=/; HttpOnly' }

  let(:non_httponly_cookie_response) do
    { 'set-cookie' => non_httponly_cookie_string }
  end

  let(:httponly_cookie_response) do
    { 'set-cookie' => httponly_cookie_string   }
  end

  let(:mixed_cookie_response) do
    { 'set-cookie' => [httponly_cookie_string, non_httponly_cookie_string] }
  end

  let(:multiple_httponly_cookie_response) do
    { 'set-cookie' => [httponly_cookie_string, another_httponly_cookie_string] }
  end

  describe '#name' do
    it 'is HttpOnly cookie' do
      expect(check.name).to eq 'HttpOnly cookie'
    end
  end

  describe '#description' do
    it 'is implemented' do
      expect(check).to respond_to :description
    end
  end

  describe '#perform' do
    it 'returns true if there are no cookies set' do
      expect(check.perform(request, no_cookie_response)).to be true
    end

    it 'returns false if the cookie is not marked httponly' do
      expect(check.perform(request, non_httponly_cookie_response)).to be false
    end

    it 'returns true if the cookie is marked httponly' do
      expect(check.perform(request, httponly_cookie_response)).to be true
    end

    it 'returns false if any cookies are not httponly' do
      expect(check.perform(request, mixed_cookie_response)).to be false
    end

    it 'returns true if all cookies are httponly' do
      expect(check.perform(request, multiple_httponly_cookie_response)).to(
        be true
      )
    end
  end
end
