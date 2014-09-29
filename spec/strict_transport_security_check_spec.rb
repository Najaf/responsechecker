require 'spec_helper'

RSpec.describe StrictTransportSecurityCheck do
  let(:unset_response) { {} }
  let(:check) { StrictTransportSecurityCheck.new }
  let(:banana_response)  { { 'strict-transport-security' => 'banana' } }
  let(:set_response) { { 'strict-transport-security' => 'max-age=31536000' } }

  describe '#name' do
    it 'is Strict transport security' do
      expect(check.name).to eq 'Strict transport security'
    end
  end

  describe '#description' do
    it 'is implemented' do
      expect(check).to respond_to :description
    end
  end

  describe '#perform' do
    it 'returns false if STS header unset' do
      expect(check.perform(nil, unset_response)).to be false
    end

    it 'returns false if STS header set to strange value' do
      expect(check.perform(nil, banana_response)).to be false
    end

    it 'returns true if STS header set correctly' do
      expect(check.perform(nil, set_response)).to be true
    end
  end
end
