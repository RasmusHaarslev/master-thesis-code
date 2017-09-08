require 'spec_helper'
require_relative './../../app/services/lexer_service.rb'

RSpec.describe LexerService do
  before :each do
    @lexer = LexerService.new(File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')))
  end

  describe '#initialize' do
    it 'initializes properly' do
      input = File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')).map(&:rstrip)
      expect(@lexer.input).to eq(input)
    end
  end

  describe '#voters' do
    it 'tokenizes voters properly' do
      expect(@lexer.voters).to eq(%w[Rasmus Troels Martin])
    end
  end

  describe '#movies' do
    it 'tokenizes movies properly' do
      expect(@lexer.movies).to eq(%w[Warcraft Batman Superman])
    end
  end

  describe '#preferences' do
    it 'tokenizes preferences properly' do
      expected = [
        %w[Rasmus Warcraft > Batman > Superman],
        %w[Troels Superman > Batman > Warcraft],
        %w[Martin Batman > Warcraft > Superman]
      ]
      expect(@lexer.preferences).to eq(expected)
    end
  end

  describe '#tokens' do
    it 'tokenizes input properly' do
      output = [
        %w[Rasmus Troels Martin],
        %w[Warcraft Batman Superman],
        [
          %w[Rasmus Warcraft > Batman > Superman],
          %w[Troels Superman > Batman > Warcraft],
          %w[Martin Batman > Warcraft > Superman]
        ]
      ]
      expect(@lexer.tokens).to eq(output)
    end
  end
end