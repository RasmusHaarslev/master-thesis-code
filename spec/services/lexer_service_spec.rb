require 'spec_helper'
require_relative './../../app/services/lexer_service.rb'

RSpec.describe LexerService do
  before :each do
    @lexer = LexerService.new(File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')))
  end

  describe '#initialize' do
    it 'initializes properly' do
      input = File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')).map { |line| line.rstrip }
      expect(@lexer.input).to eq(input)
    end
  end

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
end