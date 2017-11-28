require 'spec_helper'
require 'rails'
require_relative './../../../app/services/similarity_service.rb'


RSpec.describe SimilarityService do
  before :all do
    @reader = SimilarityService.new

    @ranked_pairs_results = 'spec/comparison/results/ranked_pairs'
    @kemeny_results       = 'spec/comparison/results/kemeny'
    @schulze_results      = 'spec/comparison/results/schulze'
    @file_names           = Dir["#{@ranked_pairs_results}/*"].map { |path| path.split('/').last }.sort_by { |name| name.split('_').first.to_i }
  end

  describe '#compare social ordering' do
    it 'Schulze vs. Kemeny' do
      puts 'Schulze vs. Kemeny'

      @file_names.each do |file_name|
        result = @reader.compare_social_ordering(
          "#{@schulze_results}/#{file_name}",
          "#{@kemeny_results}/#{file_name}"
        )
        puts "#{file_name.split('_').first.to_i} alternatives: #{result * 100}% similar"
      end
    end

    it 'Schulze vs. Ranked pairs' do
      puts 'Schulze vs. Ranked pairs'

      @file_names.each do |file_name|
        result = @reader.compare_social_ordering(
          "#{@schulze_results}/#{file_name}",
          "#{@ranked_pairs_results}/#{file_name}"
        )
        puts "#{file_name.split('_').first.to_i} alternatives: #{result * 100}% similar"
      end
    end

    it 'Ranked pairs vs. Kemeny' do
      puts 'Ranked pairs vs. Kemeny'

      @file_names.each do |file_name|
        result = @reader.compare_social_ordering(
          "#{@ranked_pairs_results}/#{file_name}",
          "#{@kemeny_results}/#{file_name}"
        )
        puts "#{file_name.split('_').first.to_i} alternatives: #{result * 100}% similar"
      end
    end
  end

  describe '#compare winner' do
    it 'Schulze vs. Kemeny' do
      puts 'Schulze vs. Kemeny'

      @file_names.each do |file_name|
        result = @reader.compare_winner(
          "#{@schulze_results}/#{file_name}",
          "#{@kemeny_results}/#{file_name}"
        )
        puts "#{file_name.split('_').first.to_i} alternatives: #{result * 100}% similar"
      end
    end

    it 'Schulze vs. Ranked pairs' do
      puts 'Schulze vs. Ranked pairs'

      @file_names.each do |file_name|
        result = @reader.compare_winner(
          "#{@schulze_results}/#{file_name}",
          "#{@ranked_pairs_results}/#{file_name}"
        )
        puts "#{file_name.split('_').first.to_i} alternatives: #{result * 100}% similar"
      end
    end

    it 'Ranked pairs vs. Kemeny' do
      puts 'Ranked pairs vs. Kemeny'

      @file_names.each do |file_name|
        result = @reader.compare_winner(
          "#{@ranked_pairs_results}/#{file_name}",
          "#{@kemeny_results}/#{file_name}"
        )
        puts "#{file_name.split('_').first.to_i} alternatives: #{result * 100}% similar"
      end
    end
  end
end
