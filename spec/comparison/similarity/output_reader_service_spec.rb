require 'spec_helper'
require 'rails'
require_relative './../../app/services/tput_reader_service.rb'


RSpec.describe OutputReaderService do
  before :all do
    @reader = OutputReaderService.new

    my_rails_root = File.expand_path('../..', __FILE__)
    @root_path_results = "#{my_rails_root}/benchmark_results/"
  end

  describe '#compare single round' do
    it 'Schulze vs. Kemeny SINGLE ROUND 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/single_round_5_voters.csv',
                              @root_path_results + 'kemeny/single_round_5_voters.csv')

      puts 'Schulze vs. Kemeny SINGLE ROUND 5 VOTERS'
      puts result
    end

    it 'Schulze vs. Ranked pairs SINGLE ROUND 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/single_round_5_voters.csv',
                                       @root_path_results + 'ranked_pairs/single_round_5_voters.csv')

      puts 'Schulze vs. Ranked pairs SINGLE ROUND 5 VOTERS'
      puts result
    end

    it 'Kemeny vs. Ranked pairs SINGLE ROUND 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'kemeny/single_round_5_voters.csv',
                                       @root_path_results + 'ranked_pairs/single_round_5_voters.csv')

      puts 'Kemeny vs. Ranked pairs SINGLE ROUND 5 VOTERS'
      puts result
    end

    it 'Schulze vs. Kemeny SINGLE ROUND 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/single_round_25_voters.csv',
                                       @root_path_results + 'kemeny/single_round_25_voters.csv')

      puts 'Schulze vs. Kemeny SINGLE ROUND 25 VOTERS'
      puts result
    end

    it 'Schulze vs. Ranked pairs SINGLE ROUND 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/single_round_25_voters.csv',
                                       @root_path_results + 'ranked_pairs/single_round_25_voters.csv')

      puts 'Schulze vs. Ranked pairs SINGLE ROUND 25 VOTERS'
      puts result
    end

    it 'Kemeny vs. Ranked pairs SINGLE ROUND 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'kemeny/single_round_25_voters.csv',
                                       @root_path_results + 'ranked_pairs/single_round_25_voters.csv')

      puts 'Kemeny vs. Ranked pairs SINGLE ROUND 25 VOTERS'
      puts result
    end
  end

  describe '#compare three round' do
    it 'Schulze vs. Kemeny THREE ROUND 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/three_round_5_voters.csv',
                                       @root_path_results + 'kemeny/three_round_5_voters.csv')

      puts 'Schulze vs. Kemeny THREE ROUND 5 VOTERS'
      puts result
    end

    it 'Schulze vs. Ranked pairs THREE ROUND 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/three_round_5_voters.csv',
                                       @root_path_results + 'ranked_pairs/three_round_5_voters.csv')

      puts 'Schulze vs. Ranked pairs THREE ROUND 5 VOTERS'
      puts result
    end

    it 'Kemeny vs. Ranked pairs THREE ROUND 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'kemeny/three_round_5_voters.csv',
                                       @root_path_results + 'ranked_pairs/three_round_5_voters.csv')

      puts 'Kemeny vs. Ranked pairs THREE ROUND 5 VOTERS'
      puts result
    end

    it 'Schulze vs. Kemeny THREE ROUND 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/three_round_25_voters.csv',
                                       @root_path_results + 'kemeny/three_round_25_voters.csv')

      puts 'Schulze vs. Kemeny THREE ROUND 25 VOTERS'
      puts result
    end

    it 'Schulze vs. Ranked pairs THREE ROUND 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze/three_round_25_voters.csv',
                                       @root_path_results + 'ranked_pairs/three_round_25_voters.csv')

      puts 'Schulze vs. Ranked pairs THREE ROUND 25 VOTERS'
      puts result
    end

    it 'Kemeny vs. Ranked pairs THREE ROUND 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'kemeny/three_round_25_voters.csv',
                                       @root_path_results + 'ranked_pairs/three_round_25_voters.csv')

      puts 'Kemeny vs. Ranked pairs THREE ROUND 25 VOTERS'
      puts result
    end
  end

  describe '#compare three round majority' do
    it 'Schulze vs. Kemeny THREE ROUND MAJORITY 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze_majority/three_round_5_voters.csv',
                                       @root_path_results + 'kemeny_majority/three_round_5_voters.csv')

      puts 'Schulze vs. Kemeny THREE ROUND MAJORITY 5 VOTERS'
      puts result
    end

    it 'Schulze vs. Ranked pairs THREE ROUND MAJORITY 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze_majority/three_round_5_voters.csv',
                                       @root_path_results + 'ranked_pairs_majority/three_round_5_voters.csv')

      puts 'Schulze vs. Ranked pairs THREE ROUND MAJORITY 5 VOTERS'
      puts result
    end

    it 'Kemeny vs. Ranked pairs THREE ROUND MAJORITY 5 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'kemeny_majority/three_round_5_voters.csv',
                                       @root_path_results + 'ranked_pairs_majority/three_round_5_voters.csv')

      puts 'Kemeny vs. Ranked pairs THREE ROUND MAJORITY 5 VOTERS'
      puts result
    end

    it 'Schulze vs. Kemeny THREE ROUND MAJORITY 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze_majority/three_round_25_voters.csv',
                                       @root_path_results + 'kemeny_majority/three_round_25_voters.csv')

      puts 'Schulze vs. Kemeny THREE ROUND MAJORITY 25 VOTERS'
      puts result
    end

    it 'Schulze vs. Ranked pairs THREE ROUND MAJORITY 25 VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'schulze_majority/three_round_25_voters.csv',
                                       @root_path_results + 'ranked_pairs_majority/three_round_25_voters.csv')

      puts 'Schulze vs. Ranked pairs THREE ROUND MAJORITY 25 VOTERS'
      puts result
    end

    it 'Kemeny vs. Ranked pairs THREE ROUND 25 MAJORITY VOTERS' do
      result = @reader.compare_outputs(@root_path_results + 'kemeny_majority/three_round_25_voters.csv',
                                       @root_path_results + 'ranked_pairs_majority/three_round_25_voters.csv')

      puts 'Kemeny vs. Ranked pairs THREE ROUND MAJORITY 25 VOTERS'
      puts result
    end
  end


end
