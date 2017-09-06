require 'spec_helper'
require_relative './../../app/services/lexer_service.rb'
require_relative './../../app/services/parser_service.rb'

RSpec.describe ParserService do
  before :each do
    @lexer  = LexerService.new(File.readlines(File.expand_path('spec/files/test_strong_preferences.txt')))
    @parser = ParserService.new(@lexer.tokens)
  end

  describe '#parse' do
    it 'parses properly' do
      output = {
          :voters      => ["Rasmus", "Troels", "Martin"],
          :movies      => ["Warcraft", "Batman", "Superman"],
          :preferences => {
              :Rasmus => [["Warcraft"], ["Batman"], ["Superman"]],
              :Troels => [["Superman"], ["Batman"], ["Warcraft"]],
              :Martin => [["Batman"], ["Warcraft"], ["Superman"]]
          } }

      expect(@parser.parse).to eq(output)
    end
  end
end