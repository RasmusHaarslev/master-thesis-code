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
    @schulze_service = SchulzeService.new
    @kemeny_service = KemenyService.new
  end

  describe '#test' do
    before :all do
      @preferences = JSON.parse(File.read('spec/benchmark_files/5_voters/25_alternatives.json'))
    end

    it 'is timed' do
      @voting_service.majority_ranked_pairs(@preferences)
    end
  end

  describe '#test2' do
    before :all do
      @preferences = JSON.parse(File.read('spec/benchmark_files/25_voters/29_alternatives.json'))
    end

    it 'is timed' do
      start = Time.now
      @voting_service.ranked_pairs(@preferences)
      puts " --- Total time: #{(Time.now - start) * 1000}ms"
    end
  end

  describe '#test3' do
    before :all do
      @preferences = {
        l4d: ['rasmus', 'andreas', 'nico', 'morten', 'troels', 'stefan', 'alex', 'kris'],
        battlerite: ['rasmus', 'troels', 'nico', 'andreas', 'morten', 'stefan', 'alex', 'kris'],
        mw2: ['andreas', 'rasmus', 'nico', 'troels', 'morten', 'stefan', 'kris', 'alex'],
        tm: ['alex', 'stefan', 'rasmus', 'andreas', 'morten', 'nico', 'troels', 'kris'],
        aoe: ['troels', 'nico', 'rasmus', 'andreas', 'stefan', 'morten', 'kris', 'alex'],
        tf2: ['rasmus', 'andreas', 'nico', 'stefan', 'morten', 'troels', 'kris', 'alex']
      }
    end

    it 'is timed' do
      puts @kemeny_service.winner(@preferences)
    end
  end
end