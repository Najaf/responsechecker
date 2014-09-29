require 'spec_helper'

RSpec.describe XssProtectionCheck do
  let(:unset_response)   { {} }
  let(:set_response)     { { 'x-xss-protection' => '1; mode=block' } }
  let(:banana_response)  { { 'x-xss-protection' => 'banana' } }
  let(:check) { XssProtectionCheck.new }

  describe '#name' do
    it 'is X-XSS-Proteciton' do
      expect(check.name).to eq 'X-XSS-Protection'
    end
  end

  describe '#description' do
    it 'is implemented' do
      expect(check).to respond_to :description
    end
  end

  describe '#perform' do
    it 'returns false if xss protection header is unset' do
      expect(check.perform(nil, unset_response)).to be false
    end

    it 'returns false if xss protection header set to strange value' do
      expect(check.perform(nil, banana_response)).to be false
    end

    it 'returns true if xss protection header set correctly' do
      expect(check.perform(nil, set_response)).to be true
    end
  end
end
