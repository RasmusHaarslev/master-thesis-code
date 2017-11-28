require 'spec_helper'
require 'csv'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/ranked_pairs_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'
require_relative './../../app/services/generate_preferences_service.rb'


RSpec.describe 'Comparison benchmarkk' do
  before :all do
    @ranked_pairs    = RankedPairsService.new
    @kemeny          = KemenyService.new
    @schulze         = SchulzeService.new
    @scenario_folder = 'spec/comparison/scenarios'
    @result_folder   = 'spec/comparison/results'
    Dir.mkdir(@result_folder) unless File.exist?(@result_folder)
    Dir.mkdir("#{@result_folder}/ranked_pairs") unless File.exist?("#{@result_folder}/ranked_pairs")
    Dir.mkdir("#{@result_folder}/kemeny") unless File.exist?("#{@result_folder}/kemeny")
    Dir.mkdir("#{@result_folder}/schulze") unless File.exist?("#{@result_folder}/schulze")
  end

  describe '#Schulze' do
    it 'does the thing' do
      puts 'Reading scenarios'
      scenarios = {}
      Dir["#{@scenario_folder}/*"]
      scenarios = Dir["#{@scenario_folder}/5_voters/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@result_folder}/single_round_5_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        scenarios.each_with_index do |scenario, idx|
          puts "Benchmarking scenario #{idx}"

          times   = []
          winners = nil
          @repetitions.times do |_|
            start   = Time.now
            winners = @schulze.calculate_schulze(scenario['movie_preferences'])
            finish  = Time.now
            times << finish - start
          end

          csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
        end
      end
    end
  end
end