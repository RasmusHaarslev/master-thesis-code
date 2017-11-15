require 'spec_helper'
require 'benchmark'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'
require_relative './../../app/services/generate_preferences_service.rb'


RSpec.describe 'Schulze-majority benchmark' do
  before :all do
    @schulze        = SchulzeService.new
    @voting_service = VotingService.new
    @folder         = 'spec/benchmark_results/schulze_majority'
    Dir.mkdir('spec/benchmark_results') unless File.exists?('spec/benchmark_results')
    Dir.mkdir('spec/benchmark_results/schulze_majority') unless File.exists?('spec/benchmark_results/schulze_majority')
  end

  describe '#Schulze-majority 3 rounds' do
    it '5 voters' do
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@folder}/three_round_5_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        scenarios.each do |scenario|
          times   = []
          winners = nil
          100.times do |_|
            start   = Time.now
            winners = @voting_service.majority_schulze(scenario)
            finish  = Time.now
            times << finish - start
          end

          csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
        end
      end
    end

    it '25 voters' do
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@folder}/three_round_25_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        scenarios.each do |scenario|
          times   = []
          winners = nil
          100.times do |_|
            start   = Time.now
            winners = @voting_service.majority_schulze(scenario)
            finish  = Time.now
            times << finish - start
          end

          csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
        end
      end
    end
  end
end