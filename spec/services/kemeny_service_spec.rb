require 'spec_helper'
require_relative './../../app/services/kemeny_service.rb'

RSpec.describe KemenyService do
  before :each do
    @kemeny = KemenyService.new([[['a'], ['b','c']], [['b'],['a'],['c']], [['b','a'],['c']], [['c'],['b'],['a']] ])
  end

  describe '#initialize' do
    it 'initializes properly' do
      expect(@kemeny.compareTwo('a', 'c')).to eq([3,0,1])
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