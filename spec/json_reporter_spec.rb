require 'spec_helper'
require 'ostruct'
require 'json'

RSpec.describe JsonReporter do

  let(:uri)      { 'http://example.com' }
  let(:check1)   { ['Check 1', 'A check for 1', true]  }
  let(:check2)   { ['Check 2', 'A check for 2', true]  }
  let(:check3)   { ['Check 3', 'A check for 3', false] }

  let(:results)  { [check1, check2, check3]  }
  let(:reporter) { JsonReporter.new(uri, results) }

  let(:expected_format) do
    {
      'checks' => [
        hash_for_check(check1),
        hash_for_check(check2),
        hash_for_check(check3)
      ]
    }
  end

  def hash_for_check((name, description, result))
    { 'name' => name, 'description' => description, 'result' => result }
  end

  describe '#output' do
    it 'returns expected output' do
      expect(JSON.parse(reporter.output)).to eq expected_format
    end
  end
end

