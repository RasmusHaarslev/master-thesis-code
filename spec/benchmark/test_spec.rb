require 'spec_helper'
require 'csv'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/ranked_pairs_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'
require_relative './../../app/services/generate_preferences_service.rb'


RSpec.describe 'Ranked-pairs-majority benchmark' do
  before :all do
    @voting_service = VotingService.new
    @ranked_pairs_service = RankedPairsService.new
  end

  # describe '#test' do
  #   before :all do
  #     @preferences = JSON.parse(File.read('spec/benchmark_files/5_voters/25_alternatives.json'))
  #   end
  #
  #   it 'is timed' do
  #     @voting_service.majority_ranked_pairs(@preferences)
  #   end
  # end

  describe '#test' do
    before :all do
      @preferences = JSON.parse(File.read('spec/benchmark_files/5_voters/25_alternatives.json'))['movie_preferences']
    end

    it 'is timed' do
      start = Time.now
      @ranked_pairs_service.resolve_timed(@preferences)
      puts " --- Total time: #{(Time.now - start) * 1000}ms"
    end
  end
end