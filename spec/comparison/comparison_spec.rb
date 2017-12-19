require 'spec_helper'
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

  describe '#Ranked pairs' do
    it 'does the thing' do
      puts 'Reading scenarios'
      scenario_hash = {}
      Dir["#{@scenario_folder}/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.each do |path_name|
        folder_name                = path_name.split('/').last
        scenario_hash[folder_name] = Dir["#{path_name}/*"].sort_by { |x| x.split('/').last.split('_').last.split('.').first.to_i }.map do |fname|
          JSON.parse(File.read(fname))
        end
      end

      scenario_hash.each do |key, scenarios|
        File.open("#{@result_folder}/ranked_pairs/#{key}.csv", 'w') do |f|
          scenarios.each do |scenario|
            f.write @ranked_pairs.resolve(scenario['movie_preferences']).join(',')
            f.write "\n"
          end
        end
      end
    end
  end

  describe '#kemeny' do
    it 'does the thing' do
      puts 'Reading scenarios'
      scenario_hash = {}
      Dir["#{@scenario_folder}/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.each do |path_name|
        folder_name                = path_name.split('/').last
        scenario_hash[folder_name] = Dir["#{path_name}/*"].sort_by { |x| x.split('/').last.split('_').last.split('.').first.to_i }.map do |fname|
          JSON.parse(File.read(fname))
        end
      end

      scenario_hash.each do |key, scenarios|
        File.open("#{@result_folder}/kemeny/#{key}.csv", 'w') do |f|
          scenarios.each do |scenario|
            f.write @kemeny.winner(scenario['movie_preferences']).join(',')
            f.write "\n"
          end
        end
      end
    end
  end

  describe '#Schulze' do
    it 'does the thing' do
      puts 'Reading scenarios'
      scenario_hash = {}
      Dir["#{@scenario_folder}/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.each do |path_name|
        folder_name                = path_name.split('/').last
        scenario_hash[folder_name] = Dir["#{path_name}/*"].sort_by { |x| x.split('/').last.split('_').last.split('.').first.to_i }.map do |fname|
          JSON.parse(File.read(fname))
        end
      end

      scenario_hash.each do |key, scenarios|
        File.open("#{@result_folder}/schulze/#{key}.csv", 'w') do |f|
          scenarios.each do |scenario|
            f.write @schulze.calculate_schulze(scenario['movie_preferences']).join(',')
            f.write "\n"
          end
        end
      end
    end
  end

  describe '#output' do
    it 'does the thing' do
      alternatives = 5
      number = 0
      file_name = Dir["#{@scenario_folder}/#{alternatives}_alternatives/*"][number]
      scenario = JSON.parse(File.read(file_name))

      puts "--- File name: #{file_name} ---"
      puts "Ranked pairs output: #{@ranked_pairs.resolve(scenario['movie_preferences']).join(', ')}"
      puts "Kemeny-young output: #{@kemeny.winner(scenario['movie_preferences']).join(', ')}"
      puts "Schulze output: #{@schulze.calculate_schulze(scenario['movie_preferences']).join(', ')}"
    end
  end
end