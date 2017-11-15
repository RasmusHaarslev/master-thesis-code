require 'spec_helper'
require 'csv'
require_relative './../../app/services/voting_service.rb'
require_relative './../../app/services/schulze_service.rb'
require_relative './../../app/services/kemeny_service.rb'
require_relative './../../app/services/ranked_pairs_service.rb'
require_relative './../../app/services/majority_service.rb'
require_relative './../../app/services/exclusion_service.rb'
require_relative './../../app/services/generate_preferences_service.rb'


RSpec.describe 'Kemeny benchmarking' do
  before :all do
    @kemeny            = KemenyService.new
    @voting_service    = VotingService.new
    @timeout_threshold = 2
    @repetitions       = 100
    @folder            = 'spec/benchmark_results/kemeny'
    Dir.mkdir('spec/benchmark_results') unless File.exist?('spec/benchmark_results')
    Dir.mkdir(@folder) unless File.exist?(@folder)
  end

  describe '#Kemeny single round' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@folder}/single_round_5_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        catch :too_slow do
          scenarios.each_with_index do |scenario, idx|
            puts "Benchmarking scenario #{idx}"

            times   = []
            winners = nil
            @repetitions.times do |_|
              start   = Time.now
              winners = @kemeny.winner(scenario['movie_preferences'])
              finish  = Time.now
              times << finish - start

              if finish - start >= @timeout_threshold
                puts 'Finished benchmark because it was too slow'
                throw :too_slow
              end
            end

            csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
          end
        end
      end
    end

    it '25 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@folder}/single_round_25_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        catch :too_slow do
          scenarios.each_with_index do |scenario, idx|
            puts "Benchmarking scenario #{idx}"

            times   = []
            winners = nil
            @repetitions.times do |_|
              start   = Time.now
              winners = @kemeny.winner(scenario['movie_preferences'])
              finish  = Time.now
              times << finish - start

              if finish - start >= @timeout_threshold
                puts 'Finished benchmark because it was too slow'
                throw :too_slow
              end
            end

            csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
          end
        end
      end
    end
  end

  describe '#Kemeny 3 rounds' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@folder}/three_round_5_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        catch :too_slow do
          scenarios.each_with_index do |scenario, idx|
            puts "Benchmarking scenario #{idx}"

            times   = []
            winners = nil
            @repetitions.times do |_|
              start   = Time.now
              winners = @voting_service.kemeny(scenario)
              finish  = Time.now
              times << finish - start

              if finish - start >= @timeout_threshold
                puts 'Finished benchmark because it was too slow'
                throw :too_slow
              end
            end

            csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
          end
        end
      end
    end

    it '25 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      CSV.open("#{@folder}/three_round_25_voters.csv", 'wb', col_sep: '&') do |csv|
        csv << %w[Alternatives Time Output]

        catch :too_slow do
          scenarios.each_with_index do |scenario, idx|
            puts "Benchmarking scenario #{idx}"

            times   = []
            winners = nil
            @repetitions.times do |_|
              start   = Time.now
              winners = @voting_service.kemeny(scenario)
              finish  = Time.now
              times << finish - start

              if finish - start >= @timeout_threshold
                puts 'Finished benchmark because it was too slow'
                throw :too_slow
              end
            end

            csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
          end
        end
      end
    end
  end
end