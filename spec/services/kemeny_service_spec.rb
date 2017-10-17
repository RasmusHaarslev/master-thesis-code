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
end