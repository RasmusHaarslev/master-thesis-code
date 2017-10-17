require 'spec_helper'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'


RSpec.describe VotingService do
  before :all do
    @voting_scenario = JSON.parse(File.read(File.expand_path('spec/files/graph_preferences.json')))
    @voting_service  = VotingService.new(@voting_scenario)
  end

  describe '#initialize' do
    it 'initializes properly' do
      expect(@voting_service.associations).to eq @voting_scenario['associations']
      expect(@voting_service.movie_preferences).to eq @voting_scenario['movie_preferences']
      expect(@voting_service.time_preferences).to eq @voting_scenario['time_preferences']
      expect(@voting_service.time_votes).to eq @voting_scenario['time_votes']
      expect(@voting_service.cinema_preferences).to eq @voting_scenario['cinema_preferences']
    end
  end

  describe '#schulze' do
    it 'Finds the winners' do
      expect(@voting_service.schulze).to eq(time: '19:00', movie: 'Batman', cinema: 'Cinemaxx')
    end
  end

  describe '#kemeny' do
    it 'Finds the winners' do
      expect(@voting_service.kemeny).to eq(time: '19:00', movie: 'Batman', cinema: 'Cinemaxx')
    end
  end

  describe '#majority_schulze' do
    it 'finds the winners' do
      expect(@voting_service.majority_schulze).to eq(time: '20:00', movie: 'Warcraft', cinema: 'Falkoner')
    end
  end

  describe '#majority_kemeny' do
    it 'finds the winners' do
      expect(@voting_service.majority_kemeny).to eq(time: '20:00', movie: 'Warcraft', cinema: 'Falkoner')
    end
  end
end