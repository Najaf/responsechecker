require 'spec_helper'

RSpec.describe FrameOptionsCheck do
  let(:deny_response)       { { 'x-frame-options' => 'DENY' } }
  let(:sameorigin_response) { { 'x-frame-options' => 'SAMEORIGIN' } }
  let(:banana_response)     { { 'x-frame-options' => 'BANANA' } }
  let(:unset_response)      { {} }
  let(:check)               { FrameOptionsCheck.new }

  describe '#name' do
    it 'is X-Frame-Options' do
      expect(check.name).to eq 'X-Frame-Options'
    end
  end

  describe '#description' do
    it 'is implemented' do
      expect(check).to respond_to :description
    end
  end

  describe '#perform' do
    it 'returns false if frame options header unset' do
      expect(check.perform(nil, unset_response)).to be false
    end

    it 'returns false if frame options header set to strange value' do
      expect(check.perform(nil, banana_response)).to be false
    end

    it 'returns true if frame options header set to DENY' do
      expect(check.perform(nil, deny_response)).to be true
    end

    it 'returns true if frame options header set to SAMEORIGIN' do
      expect(check.perform(nil, sameorigin_response)).to be true
    end
  end
end
