require 'spec_helper'
require_relative './../../app/services/ranked_pairs_service.rb'


RSpec.describe RankedPairsService do
  before :all do
    @ranked_pairs_service = RankedPairsService.new
  end

  describe '#resolve' do
    before :all do
      @preferences = {
        voter1: %w[a b d c],
        voter2: %w[b a c d],
        voter3: %w[c a d b],
        voter4: %w[a c d b]
      }
    end

    it 'resolves' do
      expect(@ranked_pairs_service.resolve(@preferences)).to eq %w[a b c d]
    end
  end
end