require 'spec_helper'
require_relative './../../app/services/ranked_pairs_service.rb'


RSpec.describe RankedPairsService do
  before :all do
    @ranked_pairs_service = RankedPairsService.new
  end

  describe '#resolve' do
    before :all do
      @preferences = {}

      count = 1
      42.times { |x| @preferences["voter_#{count}"] = %w[m n c k]; count += 1 }
      26.times { |x| @preferences["voter_#{count}"] = %w[n c k m]; count += 1 }
      15.times { |x| @preferences["voter_#{count}"] = %w[c k n m]; count += 1 }
      17.times { |x| @preferences["voter_#{count}"] = %w[k c n m]; count += 1 }
    end

    it 'resolves' do
      expect(@ranked_pairs_service.resolve(@preferences)).to eq %w[n c k m]
    end
  end
end