require 'spec_helper'
require 'ostruct'

RSpec.describe SecureCookieCheck do
  let(:check)     { SecureCookieCheck.new }
  let(:request)   { OpenStruct.new(uri: 'https://example.com/') }
  let(:no_cookie_response) { {} }

  let(:insecure_cookie_string) { 'foo=bar; path=/; HttpOnly' }
  let(:secure_cookie_string)   { 'bar=baz; path=/; Secure'   }
  let(:another_secure_cookie_string) { 'bish=bash; path=/; Secure' }

  let(:insecure_cookie_response) { { 'set-cookie' => insecure_cookie_string } }
  let(:secure_cookie_response)   { { 'set-cookie' => secure_cookie_string   } }

  let(:mixed_cookie_response) do
    { 'set-cookie' => [secure_cookie_string, insecure_cookie_string] }
  end

  let(:multiple_secure_cookie_response) do
    { 'set-cookie' => [secure_cookie_string, another_secure_cookie_string] }
  end

  describe '#name' do
    it 'is Secure cookie' do
      expect(check.name).to eq 'Secure cookie'
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

    it 'returns false if the cookie is not marked secure' do
      expect(check.perform(request, insecure_cookie_response)).to be false
    end

    it 'returns true if the cookie is marked secure' do
      expect(check.perform(request, secure_cookie_response)).to be true
    end

    it 'returns false if any cookies are not secure' do
      expect(check.perform(request, mixed_cookie_response)).to be false
    end

    it 'returns true if all cookies are secure' do
      expect(check.perform(request, multiple_secure_cookie_response)).to be true
    end
  end
end
