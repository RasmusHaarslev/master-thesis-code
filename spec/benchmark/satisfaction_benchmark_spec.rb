require 'spec_helper'
require 'json'

RSpec.describe 'Schulze satisfaction benchmarking' do
  before :all do
    @folder = 'spec/benchmark_results'
    @result_folder = 'spec/satisfaction_results'
    Dir.mkdir(@result_folder) unless File.exist?(@result_folder)
    Dir.mkdir("#{@result_folder}/schulze") unless File.exist?("#{@result_folder}/schulze")
    Dir.mkdir("#{@result_folder}/ranked_pairs") unless File.exist?("#{@result_folder}/ranked_pairs")
    Dir.mkdir("#{@result_folder}/kemeny") unless File.exist?("#{@result_folder}/kemeny")
  end

  describe '#Schulze single round' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      result = get_scores(scenarios, 'schulze/single_round_5_voters.csv', 5)

      File.open("#{@result_folder}/schulze/single_round_5_voters.csv", 'w+') do |f|
        f.puts(result)
      end


    end


    it '25 voters' do

      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      result = get_scores(scenarios, 'schulze/single_round_25_voters.csv', 25)

      File.open("#{@result_folder}/schulze/single_round_25_voters.csv", 'w+') do |f|
        f.puts(result)
      end
    end


  end

  describe '#Ranked Pairs single round' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      result = get_scores(scenarios, 'ranked_pairs/single_round_5_voters.csv', 5)

      File.open("#{@result_folder}/ranked_pairs/single_round_5_voters.csv", 'w+') do |f|
        f.puts(result)
      end
    end

    it '25 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      result = get_scores(scenarios, 'ranked_pairs/single_round_25_voters.csv', 25)

      File.open("#{@result_folder}/ranked_pairs/single_round_25_voters.csv", 'w+') do |f|
        f.puts(result)
      end
    end

  end

  describe '#Kemeny-Young single round' do
    it '5 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/5_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      result = get_scores(scenarios, 'kemeny/single_round_5_voters.csv', 5)

      File.open("#{@result_folder}/kemeny/single_round_5_voters.csv", 'w+') do |f|
        f.puts(result)
      end
    end

    it '25 voters' do
      puts 'Reading scenarios'
      scenarios = Dir['spec/benchmark_files/25_voters/*'].sort_by { |x| x.split('/').last.split('_').first.to_i }.map do |fname|
        JSON.parse(File.read(fname))
      end

      result = get_scores(scenarios, 'kemeny/single_round_25_voters.csv', 25)

      File.open("#{@result_folder}/kemeny/single_round_25_voters.csv", 'w+') do |f|
        f.puts(result)
      end
    end

  end

  def get_scores(scenarios, filename, voters)
    benchmarks = Array.new
    for a in IO.readlines("#{@folder}/#{filename}")
      ranking = a.split('&')[2].split(',')
      benchmarks << ranking
    end
    benchmarks.shift

    result = ['Alternatives&Score&Output']
    satisfaction_score = 0
    benchmarks.zip(scenarios).each_with_index do | (results, scenario), index |
      #puts index, results, scenario
      average_score = 0.0
      scenario['movie_preferences'].values.each do |prefs|
        winner = results[0]
        index = prefs.index(winner) + 1
        satisfaction_score += calculate_score(index.to_f+1, ranking.length.to_f)
        average_score += calculate_score(index.to_f+1, ranking.length.to_f)
      end
      result.push("#{scenario['movies'].length}&#{average_score/scenario['voters'].length.to_f}&#{scenario['movie_preferences'].values.join(',')}")
    end
    puts filename.split('.')[0].gsub('/', ': '), satisfaction_score /= (benchmarks.length*voters.to_f)

    result
  end

  def calculate_score(index, length)
    (index/length-1)/(1.to_f/length-1)
  end

end