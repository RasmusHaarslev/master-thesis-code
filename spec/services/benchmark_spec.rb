require 'spec_helper'
require 'benchmark'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'


RSpec.describe 'Benchmark' do
  before :all do
    @voting_scenario = JSON.parse(File.read(File.expand_path('spec/files/graph_preferences.json')))
    @voting_service  = VotingService.new(@voting_scenario)
    @schulze         = SchulzeService.new
    @small_letters = ('a'..'z').to_a
    @big_letters = ('A'..'Z').to_a
  end

  describe '#single round 3 voters' do
    it 'schulze' do
      preferences = (2...20).map do |x|
        Hash[@big_letters[0...3].map { |y| [y, @small_letters[0..x].shuffle] }]
      end

      Benchmark.bm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end
  end

  describe '#single round 10 voters' do
    it 'schulze' do
      preferences = (2...20).map do |x|
        Hash[@big_letters[0...10].map { |y| [y, @small_letters[0..x].shuffle] }]
      end

      Benchmark.bm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end
  end
end