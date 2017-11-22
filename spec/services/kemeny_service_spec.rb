require 'spec_helper'
require_relative './../../app/services/kemeny_service.rb'

RSpec.describe KemenyService do
  before :all do
    @data = JSON.parse(File.read(File.expand_path('spec/files/graph_preferences.json')))
    @kemeny = KemenyService.new
  end

  describe '#winner' do
    it 'Finds best ranking for movies' do
      expect(@kemeny.winner(@data['movie_preferences'])).to eq ['Batman', 'Warcraft', 'Superman']
    end
  end

  describe '#performance' do
    it 'Finds best ranking for movies' do
      hat = JSON.parse(File.read('spec/benchmark_files/5_voters/8_alternatives.json'))
      @kemeny.winner(hat['movie_preferences'])
    end
  end
end