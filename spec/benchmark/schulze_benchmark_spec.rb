require 'spec_helper'
require 'benchmark'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'
require_relative './../../app/services/generate_preferences_service.rb'


RSpec.describe 'Benchmark' do
  before :all do
    @schulze = SchulzeService.new
    @folder  = 'spec/benchmark_results'
  end

  describe '#Schulze single round' do
    it '3 voters' do
      $stdout      = File.new("#{@folder}/single_round_3_voters.log", 'w')
      $stdout.sync = true

      preferences = (2...100).map do |x|
        GeneratePreferencesService.new.generate(3, x, 0, 0)['movie_preferences']
      end

      Benchmark.bmbm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end

    it '10 voters' do
      $stdout      = File.new("#{@folder}/single_round_10_voters.log", 'w')
      $stdout.sync = true

      preferences = (2...100).map do |x|
        GeneratePreferencesService.new.generate(10, x, 0, 0)['movie_preferences']
      end

      Benchmark.bmbm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end

    it '100 voters' do
      $stdout      = File.new("#{@folder}/single_round_100_voters.log", 'w')
      $stdout.sync = true

      preferences = (2...100).map do |x|
        GeneratePreferencesService.new.generate(100, x, 0, 0)['movie_preferences']
      end

      Benchmark.bmbm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end
  end

  describe '#Schulze 3 rounds' do
    it '3 voters' do
      $stdout      = File.new("#{@folder}/three_rounds_3_voters.log", 'w')
      $stdout.sync = true

      preferences = (2...20).map do |x|
        GeneratePreferencesService.new.generate(3, x, x, x)
      end

      Benchmark.bmbm(15) do |x|
        preferences.each do |preference|
          @voting_scenario = VotingService.new(preference)
          x.report("#{preference.values.first.length} alternatives:") { @voting_scenario.schulze }
        end
      end
    end

    it '10 voters' do
      $stdout      = File.new("#{@folder}/three_rounds_10_voters.log", 'w')
      $stdout.sync = true

      preferences = (2...100).map do |x|
        Hash[(0...10).map { |y| [y, (0..x).to_a.shuffle] }]
      end

      Benchmark.bmbm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end

    it '100 voters' do
      $stdout      = File.new("#{@folder}/three_rounds_100_voters.log", 'w')
      $stdout.sync = true

      preferences = (2...100).map do |x|
        Hash[(0...100).map { |y| [y, (0..x).to_a.shuffle] }]
      end

      Benchmark.bmbm(15) do |x|
        preferences.each do |preference|
          x.report("#{preference.values.first.length} alternatives:") { @schulze.calculate_schulze(preference) }
        end
      end
    end
  end
end