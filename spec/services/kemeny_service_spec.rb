require 'spec_helper'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/lexer_service.rb'
require_relative './../../app/services/parser_service.rb'

RSpec.describe KemenyService do
  before :each do
    lexer = LexerService.new(File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')))
    @parser = ParserService.new(lexer.tokens)
    @parser.parse_preference(lexer.preferences)
    @movies = @parser.parse[:movies]
    @kemeny = KemenyService.new(@parser.parse[:preferences])
  end

  describe '#compareTwo' do
    it 'initializes properly' do
      warcraft = @movies[0]
      superman = @movies[2]
      expect(@kemeny.compareTwo(warcraft, superman)).to eq([2,0,1])
    end
  end

  describe '#pairCombinations' do
    it 'gets correct pair combinations from parser input' do
      expect(@kemeny.pairCombination(@movies)).to eq([["Warcraft", "Batman"], ["Warcraft", "Superman"], ["Batman", "Superman"]])
    end
  end

  describe '#pairCombinations' do
    it 'all pairs' do
      @kemeny.pairCombination(@movies).each do |x, y|
        @kemeny.compareTwo(x, y)
      end
    end
  end



  """
  describe '#voters' do
    it 'tokenizes voters properly' do
      expect(@lexer.voters).to eq(%w(Rasmus Troels Martin))
    end
  end

  describe '#movies' do
    it 'tokenizes movies properly' do
      expect(@lexer.movies).to eq(%w(Warcraft Batman Superman))
    end
  end
  """
end