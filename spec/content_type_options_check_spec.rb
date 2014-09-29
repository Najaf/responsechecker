require 'spec_helper'

RSpec.describe ContentTypeOptionsCheck do
  let(:unset_response)   { {} }
  let(:nosniff_response) { { 'x-content-type-options' => 'nosniff' } }
  let(:banana_response)  { { 'x-content-type-options' => 'banana' } }
  let(:check)            { ContentTypeOptionsCheck.new }

  describe '#name' do
    it 'is X-Content-Type-Options' do
      expect(check.name).to eq 'X-Content-Type-Options'
    end
  end

  describe '#description' do
    it 'is implemented' do
      expect(check).to respond_to :description
    end
  end

  describe '#perform' do
    it 'returns false if content type options header unset' do
      expect(check.perform(nil, unset_response)).to be false
    end

    it 'returns false if content type options header set to strange value' do
      expect(check.perform(nil, banana_response)).to be false
    end

    it 'returns true if content type options header set to nosniff' do
      expect(check.perform(nil, nosniff_response)).to be true
    end
  end

end
