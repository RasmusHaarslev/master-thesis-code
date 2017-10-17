require 'spec_helper'
require_relative './../../app/services/exclusion_service.rb'


RSpec.describe ExclusionService do
  before :each do
    @data          = JSON.parse(File.read(File.expand_path('spec/files/graph_preferences.json')))
    @first_winner  = @data['associations'].keys.first
    @second_winner = @data['associations'][@first_winner].keys.first
  end

  describe '#exclude_one' do
    it 'Excludes movies' do
      @result = {
        'Rasmus' => %w[Batman Superman],
        'Troels' => %w[Superman Batman],
        'Martin' => %w[Batman Superman]
      }

      expect(
        ExclusionService.exclude_one(
          @first_winner,
          @data['associations'],
          @data['movie_preferences']
        )
      ).to eq @result
    end
  end

  describe '#exclude_two' do
    it 'Excludes cinemas' do
      @result = {
        'Rasmus' => %w[Cinemaxx Palads],
        'Troels' => %w[Palads Cinemaxx],
        'Martin' => %w[Cinemaxx Palads]
      }

      expect(
        ExclusionService.exclude_two(
          @first_winner,
          @second_winner,
          @data['associations'],
          @data['cinema_preferences']
        )
      ).to eq @result
    end
  end
end