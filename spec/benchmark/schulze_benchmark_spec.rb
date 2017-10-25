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
    @voting_service = VotingService.new
    @folder  = 'spec/benchmark_results/schulze'
    Dir.mkdir('spec/benchmark_results') unless File.exists?('spec/benchmark_results')
    Dir.mkdir('spec/benchmark_results/schulze') unless File.exists?('spec/benchmark_results/schulze')
  end

  describe '#Schulze single round' do
    it '5 voters' do
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      $stdout      = File.open("#{@folder}/single_round_5_voters.log", 'w')
      $stdout.sync = true

      Benchmark.bmbm(15) do |x|
        scenarios.each do |scenario|
          x.report("#{scenario['movies'].length} alternatives:") do
            @schulze.calculate_schulze(scenario['movie_preferences'])
          end
        end
      end
    end

    it '25 voters' do
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      $stdout      = File.open("#{@folder}/single_round_25_voters.log", 'w')
      $stdout.sync = true

      Benchmark.bmbm(15) do |x|
        scenarios.each do |scenario|
          x.report("#{scenario['movies'].length} alternatives:") do
            @schulze.calculate_schulze(scenario['movie_preferences'])
          end
        end
      end
    end
  end

  describe '#Schulze 3 rounds' do
    it '5 voters' do
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      $stdout      = File.open("#{@folder}/three_round_5_voters.log", 'w')
      $stdout.sync = true

      Benchmark.bmbm(15) do |x|
        scenarios.each do |scenario|
          x.report("#{scenario['movies'].length} alternatives:") do
            @voting_service.schulze(scenario)
          end
        end
      end
    end

    it '25 voters' do
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      $stdout      = File.open("#{@folder}/three_round_25_voters.log", 'w')
      $stdout.sync = true

      Benchmark.bmbm(15) do |x|
        scenarios.each do |scenario|
          x.report("#{scenario['movies'].length} alternatives:") do
            @voting_service.schulze(scenario)
          end
        end
      end
    end
  end
end