require 'spec_helper'
require 'ostruct'

class BlankCheck
  attr_reader :name, :description
  def initialize(name, description, result)
    @name, @description, @result = name, description, result
  end

  def perform(_, _)
    @result
  end

  def to_a
    [@name, @description, @result]
  end
end

RSpec.describe Checker do
  let(:example_url) { 'http://example.com/' }

  let(:good_check) do
    BlankCheck.new('Good', 'desc', true)
  end

  let(:bad_check) do
    BlankCheck.new('Good', 'desc', false)
  end

  let(:empty_checker) { Checker.new(example_url) }
  let(:loaded_checker) do
    empty_checker.tap do |c|
      c << good_check
      c << bad_check
    end
  end

  let(:loaded_checker_results) { loaded_checker.perform_checks }

  describe '#new' do
    it 'sets `url` attribute' do
      expect(empty_checker.url).to eq example_url
    end
  end

  describe '#perform_checks' do
    it 'contains results of all configured checks' do
      expect(loaded_checker_results).to include(good_check.to_a)
      expect(loaded_checker_results).to include(bad_check.to_a)
    end
  end
end
