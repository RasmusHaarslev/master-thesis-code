require 'spec_helper'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/lexer_service.rb'
require_relative './../../app/services/parser_service.rb'

RSpec.describe KemenyService do
  before :each do
    @lexer = LexerService.new(File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')))
    @parser = ParserService.new()
    #@kemeny = KemenyService.new([[['a'], ['b','c']], [['b'],['a'],['c']], [['b','a'],['c']], [['c'],['b'],['a']] ])
    @kemeny = KemenyService.new(@lexer.preferences)
  end

  describe '#initialize' do
    it 'initializes properly' do
      print @pr
      expect(@kemeny.compareTwo(@lexer.movies[0], @lexer.movies[2])).to eq([0,3,0])
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