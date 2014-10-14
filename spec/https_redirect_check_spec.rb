require 'spec_helper'

RSpec.describe HttpsRedirectCheck do

  let(:check) { HttpsRedirectCheck.new }

  describe '#name' do
    it "returns 'HTTP => HTTPS redirect'" do
      expect(check.name).to eql 'HTTP => HTTPS redirect'
    end
  end

  describe '#description' do
    it 'is implemented' do
      expect(check).to respond_to :description
    end
  end

  describe '#perform' do
  end

end
