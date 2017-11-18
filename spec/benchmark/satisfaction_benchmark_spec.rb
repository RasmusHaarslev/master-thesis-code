require 'spec_helper'
require 'json'

RSpec.describe 'Schulze satisfaction benchmarking' do
  before :all do
    @folder = 'spec/benchmark_results'
    @result_folder = 'spec/satisfaction_results/schulze'
    Dir.mkdir(@result_folder) unless File.exist?(@result_folder)
  end

  describe '#Schulze single round' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      junk = Array.new
      for a in IO.readlines("#{@folder}/schulze/single_round_5_voters.csv")
        ranking = a.split('&')[2].split(',')
        junk << ranking
      end
      junk.shift

      result = ['Alternatives&Score&Output']
      satisfaction_score = 0
      junk.zip(scenarios).each do |results, scenarios|
        average_score = 0.0
        scenarios['movie_preferences'].values.each do |prefs|
          winner = results[0]
          index = prefs.index(winner) + 1
          satisfaction_score += calculate_score(index.to_f+1, ranking.length.to_f)
          average_score += calculate_score(index.to_f+1, ranking.length.to_f)
        end
        result.push("#{scenarios['movies'].length}&#{average_score/scenarios['voters'].length.to_f}&#{scenarios['movie_preferences'].values.join(',')}")
      end

      puts 'final score: ', satisfaction_score /= (junk.length*5.to_f)

      File.open("#{@result_folder}/single_round_5_voters.csv", 'w+') do |f|
        f.puts(result)
      end

    end


    it '25 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      junk = Array.new
      for a in IO.readlines("#{@folder}/schulze/single_round_25_voters.csv")
        ranking = a.split('&')[2].split(',')
        junk << ranking
      end
      junk.shift

      result = ['Alternatives&Score&Output']
      satisfaction_score = 0
      junk.zip(scenarios).each do |results, scenarios|
        average_score = 0.0
        scenarios['movie_preferences'].values.each do |prefs|
          winner = results[0]
          index = prefs.index(winner) + 1
          satisfaction_score += calculate_score(index.to_f+1, ranking.length.to_f)
          average_score += calculate_score(index.to_f+1, ranking.length.to_f)
        end
        result.push("#{scenarios['movies'].length}&#{average_score/scenarios['voters'].length.to_f}&#{scenarios['movie_preferences'].values.join(',')}")
      end

      puts 'final score: ', satisfaction_score /= (junk.length*5.to_f)

      File.open("#{@result_folder}/single_round_25_voters.csv", 'w+') do |f|
        f.puts(result)
      end

    end


  end

  def calculate_score(index, length)
    (index/length-1)/(1.to_f/length-1)
  end

end