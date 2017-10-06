require 'spec_helper'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/lexer_service.rb'
require_relative './../../app/services/parser_service.rb'

RSpec.describe KemenyService do
  before :all do
    @data = JSON.parse(File.read(File.expand_path('spec/files/graph_preferences.json')))
    @movies = @data['movies']
    @kemeny = KemenyService.new(@data['movie_preferences'])
  end

  describe '#pairCombinations' do
    it 'gets correct pair combinations from parser input' do
      expect(@kemeny.preferenceOrderings(@movies)).to eq([["Warcraft", "Batman", "Superman"], ["Warcraft", "Superman", "Batman"], ["Batman", "Warcraft", "Superman"], ["Batman", "Superman", "Warcraft"], ["Superman", "Warcraft", "Batman"], ["Superman", "Batman", "Warcraft"]])
      expect(@kemeny.choicePairs(@movies)).to eq([["Warcraft", "Batman"], ["Warcraft", "Superman"], ["Batman", "Superman"]])
    end
  end

  describe '#preferenceRankings' do
    it 'gets correct preference rankings from parser input' do
      expect(@kemeny.preferenceOrderings(@movies)).to eq([["Warcraft", "Batman", "Superman"], ["Warcraft", "Superman", "Batman"], ["Batman", "Warcraft", "Superman"], ["Batman", "Superman", "Warcraft"], ["Superman", "Warcraft", "Batman"], ["Superman", "Batman", "Warcraft"]])
    end
  end

  describe '#pairCombinations' do
    it 'all pairs' do
      warcraft = @movies[0]
      superman = @movies[2]
      print "Score #{warcraft} > #{superman}: #{@kemeny.getScore(warcraft, superman)}\n"
      print "Slices: #{@kemeny.preferenceOrderings(@movies)[0]}\n"
    end
  end

  describe 'find winner' do
    it 'winner?' do
      print "Winner: #{@kemeny.getWinner(@movies)}\n"
    end
  end

  # describe '#voters' do
  #   it 'tokenizes voters properly' do
  #     expect(@lexer.voters).to eq(%w(Rasmus Troels Martin))
  #   end
  # end
  #
  # describe '#movies' do
  #   it 'tokenizes movies properly' do
  #     expect(@lexer.movies).to eq(%w(Warcraft Batman Superman))
  #   end
  # end
end