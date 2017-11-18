require 'spec_helper'
require 'csv'
require 'json'

RSpec.describe 'Kemeny benchmarking' do
  before :all do
    @folder            = 'spec/benchmark_results'
  end

  describe '#Kemeny single round' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

#      junk=CSV.open("#{@folder}/single_round_5_voters.csv",'r', col_step: '&')

      # read the sql based .csv file, by lines
      junk = Array.new
      for a in IO.readlines("#{@folder}/schulze/single_round_5_voters.csv")
        ranking = a.split('&')[2].split(',')
        junk << ranking
      end
      junk.shift
      puts junk.length
      puts scenarios.length
      satisfaction_score = 0

      junk.zip(scenarios).each do |results, scenarios|
        scenarios['movie_preferences'].values.each do |prefs|
          winner = results[0]
          index = prefs.index(winner) + 1
          satisfaction_score += calculate_score(index.to_f+1, ranking.length.to_f)
        end
      end

      puts 'final score: ', satisfaction_score /= (junk.length*5.to_f)

    end
  end

  def calculate_score(index, length)
    (index/length-1)/(1.to_f/length-1)
  end


      # CSV.open("#{@folder}/single_round_5_voters.csv", 'wb', col_sep: '&') do |csv|
      #   csv << %w[Alternatives Time Output]
      #
      #   catch :too_slow do
      #     scenarios.each_with_index do |scenario, idx|
      #       puts "Benchmarking scenario #{idx}"
      #
      #       times   = []
      #       @repetitions.times do |_|
      #         start   = Time.now
      #         @voting_service.kemeny(scenario)
      #         finish  = Time.now
      #         times << finish - start
      #
      #         if finish - start >= @timeout_threshold
      #           puts 'Finished benchmark because it was too slow'
      #           throw :too_slow
      #         end
      #       end
      #
      #       csv << [scenario['movies'].length, times.sum / times.length]
      #     end
      #   end
      # end

  #   it '25 voters' do
  #     puts 'Reading scenarios'
  #     scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
  #       JSON.parse(File.read(fname))
  #     end
  #
  #     CSV.open("#{@folder}/single_round_25_voters.csv", 'wb', col_sep: '&') do |csv|
  #       csv << %w[Alternatives Time Output]
  #
  #       catch :too_slow do
  #         scenarios.each_with_index do |scenario, idx|
  #           puts "Benchmarking scenario #{idx}"
  #
  #           times   = []
  #           winners = nil
  #           @repetitions.times do |_|
  #             start   = Time.now
  #             winners = @kemeny.winner(scenario['movie_preferences'])
  #             finish  = Time.now
  #             times << finish - start
  #
  #             if finish - start >= @timeout_threshold
  #               puts 'Finished benchmark because it was too slow'
  #               throw :too_slow
  #             end
  #           end
  #
  #           csv << [scenario['movies'].length, times.sum / times.length, winners.join(',')]
  #         end
  #       end
  #     end
  #   end
  # end
  #
  # describe '#Kemeny 3 rounds' do
  #   it '5 voters' do
  #     puts 'Reading scenarios'
  #     scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
  #       JSON.parse(File.read(fname))
  #     end
  #
  #     CSV.open("#{@folder}/three_round_5_voters.csv", 'wb', col_sep: '&') do |csv|
  #       csv << %w[Alternatives Time Output]
  #
  #       catch :too_slow do
  #         scenarios.each_with_index do |scenario, idx|
  #           puts "Benchmarking scenario #{idx}"
  #
  #           times   = []
  #           @repetitions.times do |_|
  #             start   = Time.now
  #             @voting_service.kemeny(scenario)
  #             finish  = Time.now
  #             times << finish - start
  #
  #             if finish - start >= @timeout_threshold
  #               puts 'Finished benchmark because it was too slow'
  #               throw :too_slow
  #             end
  #           end
  #
  #           csv << [scenario['movies'].length, times.sum / times.length]
  #         end
  #       end
  #     end
  #   end
  #
  #   it '25 voters' do
  #     puts 'Reading scenarios'
  #     scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
  #       JSON.parse(File.read(fname))
  #     end
  #
  #     CSV.open("#{@folder}/three_round_25_voters.csv", 'wb', col_sep: '&') do |csv|
  #       csv << %w[Alternatives Time Output]
  #
  #       catch :too_slow do
  #         scenarios.each_with_index do |scenario, idx|
  #           puts "Benchmarking scenario #{idx}"
  #
  #           times   = []
  #           @repetitions.times do |_|
  #             start   = Time.now
  #             @voting_service.kemeny(scenario)
  #             finish  = Time.now
  #             times << finish - start
  #
  #             if finish - start >= @timeout_threshold
  #               puts 'Finished benchmark because it was too slow'
  #               throw :too_slow
  #             end
  #           end
  #
  #           csv << [scenario['movies'].length, times.sum / times.length]
  #         end
  #       end
  #     end
  #   end
  # end


end