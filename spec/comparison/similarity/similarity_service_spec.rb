require 'spec_helper'
require 'rails'
require_relative './../../../app/services/similarity_service.rb'


RSpec.describe SimilarityService do
  before :all do
    @reader = SimilarityService.new

    @root_path_results = 'spec/comparison/results'
  end

  describe '#compare social ordering' do
    it 'Schulze vs. Kemeny' do
      puts 'Schulze vs. Kemeny'

      result2 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/2_alternatives.csv",
        "#{@root_path_results}/kemeny/2_alternatives.csv"
      )
      puts "2 alternatives: #{result2 * 100}% similar"

      result3 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/3_alternatives.csv",
        "#{@root_path_results}/kemeny/3_alternatives.csv"
      )
      puts "3 alternatives: #{result3 * 100}% similar"

      result4 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/4_alternatives.csv",
        "#{@root_path_results}/kemeny/4_alternatives.csv"
      )
      puts "4 alternatives: #{result4 * 100}% similar"

      result5 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/5_alternatives.csv",
        "#{@root_path_results}/kemeny/5_alternatives.csv"
      )
      puts "5 alternatives: #{result5 * 100}% similar"
    end

    it 'Schulze vs. Ranked pairs' do
      puts 'Schulze vs. Ranked pairs'

      result2 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/2_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/2_alternatives.csv"
      )
      puts "2 alternatives: #{result2 * 100}% similar"

      result3 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/3_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/3_alternatives.csv"
      )
      puts "3 alternatives: #{result3 * 100}% similar"

      result4 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/4_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/4_alternatives.csv"
      )
      puts "4 alternatives: #{result4 * 100}% similar"

      result5 = @reader.compare_social_ordering(
        "#{@root_path_results}/schulze/5_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/5_alternatives.csv"
      )
      puts "5 alternatives: #{result5 * 100}% similar"
    end

    it 'Kemeny vs. Ranked pairs' do
      puts 'Kemeny vs. Ranked pairs'

      result2 = @reader.compare_social_ordering(
        "#{@root_path_results}/kemeny/2_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/2_alternatives.csv"
      )
      puts "2 alternatives: #{result2 * 100}% similar"

      result3 = @reader.compare_social_ordering(
        "#{@root_path_results}/kemeny/3_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/3_alternatives.csv"
      )
      puts "3 alternatives: #{result3 * 100}% similar"

      result4 = @reader.compare_social_ordering(
        "#{@root_path_results}/kemeny/4_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/4_alternatives.csv"
      )
      puts "4 alternatives: #{result4 * 100}% similar"

      result5 = @reader.compare_social_ordering(
        "#{@root_path_results}/kemeny/5_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/5_alternatives.csv"
      )
      puts "5 alternatives: #{result5 * 100}% similar"
    end
  end

  describe '#compare winner' do
    it 'Schulze vs. Kemeny' do
      puts 'Schulze vs. Kemeny'

      result2 = @reader.compare_winner(
        "#{@root_path_results}/schulze/2_alternatives.csv",
        "#{@root_path_results}/kemeny/2_alternatives.csv"
      )
      puts "2 alternatives: #{result2 * 100}% similar"

      result3 = @reader.compare_winner(
        "#{@root_path_results}/schulze/3_alternatives.csv",
        "#{@root_path_results}/kemeny/3_alternatives.csv"
      )
      puts "3 alternatives: #{result3 * 100}% similar"

      result4 = @reader.compare_winner(
        "#{@root_path_results}/schulze/4_alternatives.csv",
        "#{@root_path_results}/kemeny/4_alternatives.csv"
      )
      puts "4 alternatives: #{result4 * 100}% similar"

      result5 = @reader.compare_winner(
        "#{@root_path_results}/schulze/5_alternatives.csv",
        "#{@root_path_results}/kemeny/5_alternatives.csv"
      )
      puts "5 alternatives: #{result5 * 100}% similar"
    end

    it 'Schulze vs. Ranked pairs' do
      puts 'Schulze vs. Ranked pairs'

      result2 = @reader.compare_winner(
        "#{@root_path_results}/schulze/2_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/2_alternatives.csv"
      )
      puts "2 alternatives: #{result2 * 100}% similar"

      result3 = @reader.compare_winner(
        "#{@root_path_results}/schulze/3_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/3_alternatives.csv"
      )
      puts "3 alternatives: #{result3 * 100}% similar"

      result4 = @reader.compare_winner(
        "#{@root_path_results}/schulze/4_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/4_alternatives.csv"
      )
      puts "4 alternatives: #{result4 * 100}% similar"

      result5 = @reader.compare_winner(
        "#{@root_path_results}/schulze/5_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/5_alternatives.csv"
      )
      puts "5 alternatives: #{result5 * 100}% similar"
    end

    it 'Kemeny vs. Ranked pairs' do
      puts 'Kemeny vs. Ranked pairs'

      result2 = @reader.compare_winner(
        "#{@root_path_results}/kemeny/2_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/2_alternatives.csv"
      )
      puts "2 alternatives: #{result2 * 100}% similar"

      result3 = @reader.compare_winner(
        "#{@root_path_results}/kemeny/3_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/3_alternatives.csv"
      )
      puts "3 alternatives: #{result3 * 100}% similar"

      result4 = @reader.compare_winner(
        "#{@root_path_results}/kemeny/4_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/4_alternatives.csv"
      )
      puts "4 alternatives: #{result4 * 100}% similar"

      result5 = @reader.compare_winner(
        "#{@root_path_results}/kemeny/5_alternatives.csv",
        "#{@root_path_results}/ranked_pairs/5_alternatives.csv"
      )
      puts "5 alternatives: #{result5 * 100}% similar"
    end
  end
end
