require 'spec_helper'
require 'json'

RSpec.describe 'Schulze satisfaction benchmarking' do
  before :all do
    @scenario_folder = 'spec/comparison/scenarios'
    @result_folder   = 'spec/comparison/results'
  end

  describe '#Satisfaction scores' do
    it 'Ranked pairs' do
      puts 'Ranked pairs satisfaction'

      scenario_hash = {}
      Dir["#{@scenario_folder}/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.each do |path_name|
        folder_name                = path_name.split('/').last
        scenario_hash[folder_name] = Dir["#{path_name}/*"].sort_by { |x| x.split('/').last.split('_').last.split('.').first.to_i }.map do |fname|
          JSON.parse(File.read(fname))
        end
      end

      social_orderings = {}
      scenario_hash.each do |key, scenario|
        social_orderings[key] = File.readlines("#{@result_folder}/ranked_pairs/#{key}.csv").map { |line| line.split(',') }
      end

      scenario_hash.each do |key, scenarios|
        score = get_score(scenarios, social_orderings[key])
        puts "#{key.split('_').first.to_i} alternatives: #{score}"
      end
    end

    it 'Kemeny' do
      puts 'Kemeny satisfaction'

      scenario_hash = {}
      Dir["#{@scenario_folder}/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.each do |path_name|
        folder_name                = path_name.split('/').last
        scenario_hash[folder_name] = Dir["#{path_name}/*"].sort_by { |x| x.split('/').last.split('_').last.split('.').first.to_i }.map do |fname|
          JSON.parse(File.read(fname))
        end
      end

      social_orderings = {}
      scenario_hash.each do |key, scenario|
        social_orderings[key] = File.readlines("#{@result_folder}/kemeny/#{key}.csv").map { |line| line.split(',') }
      end

      scenario_hash.each do |key, scenarios|
        score = get_score(scenarios, social_orderings[key])
        puts "#{key.split('_').first.to_i} alternatives: #{score}"
      end
    end

    it 'Schulze' do
      puts 'Schulze satisfaction'

      scenario_hash = {}
      Dir["#{@scenario_folder}/*"].sort_by { |x| x.split('/').last.split('_').first.to_i }.each do |path_name|
        folder_name                = path_name.split('/').last
        scenario_hash[folder_name] = Dir["#{path_name}/*"].sort_by { |x| x.split('/').last.split('_').last.split('.').first.to_i }.map do |fname|
          JSON.parse(File.read(fname))
        end
      end

      social_orderings = {}
      scenario_hash.each do |key, scenario|
        social_orderings[key] = File.readlines("#{@result_folder}/schulze/#{key}.csv").map { |line| line.split(',') }
      end

      scenario_hash.each do |key, scenarios|
        score = get_score(scenarios, social_orderings[key])
        puts "#{key.split('_').first.to_i} alternatives: #{score}"
      end
    end
  end

  def get_score(scenarios, social_orderings)
    voters = scenarios.first['voters'].length.to_f

    satisfaction_scores = []
    social_orderings.each_with_index do |social_ordering, index|
      scenario_score = 0.0

      scenarios[index]['movie_preferences'].values.each do |preferences|
        index          = preferences.index(social_ordering.first) + 1
        scenario_score += calculate_score(index, social_ordering.length)
      end

      satisfaction_scores << scenario_score / voters
    end

    satisfaction_scores.sum / scenarios.length.to_f
  end

  def calculate_score(index, length)
    (index.to_f / length.to_f - 1) / (1.to_f / length.to_f - 1)
  end
end