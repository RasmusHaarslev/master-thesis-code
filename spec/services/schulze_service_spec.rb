require 'spec_helper'
require_relative './../../app/services/schulze_service.rb'


RSpec.describe SchulzeService do
  before :each do
    @schulze         = SchulzeService.new
    @voting_proiles  = {
        person1: ['A', 'B', 'D', 'C'],
        person2: ['A', 'D', 'C', 'B'],
        person3: ['C', 'D', 'B', 'A'],
        person4: ['A', 'D', 'C', 'B']
    }
    @candidate_index = Hash[@voting_proiles[:person1].sort.zip (0..@voting_proiles[:person1].size)]
  end

  describe '#calculate_schulze' do
    it 'calculates schulze for a hash of preferences' do
      preferences = {
          person1: [['A'], ['B', 'D'], ['C']],
          person2: [['A'], ['D'], ['C'], ['B']],
          person3: [['C', 'D'], ['B'], ['A']],
          person4: [['A', 'D'], ['C', 'B']]
      }
      puts @schulze.calculate_schulze preferences
    end
  end

  describe '#pair_wise_matrix' do
    it 'should calculate the pairwise matrix of the preferences' do
      output = [
          [0, 3, 3, 3],
          [1, 0, 1, 1],
          [1, 3, 0, 1],
          [1, 3, 3, 0]
      ]

      expect(@schulze.pair_wise_matrix(@voting_proiles, @candidate_index))
          .to eq(Matrix[output])
    end
  end

  # describe '#strongest_path_matrix' do
  #   it 'should create a graph only consisting of strongest paths from preference matrix' do
  #     output = [
  #         [0, 2, 3, 3],
  #         [0, 0, 0, 0],
  #         [0, 3, 0, 0],
  #         [0, 3, 3, 0]
  #     ]
  #       pair_wise_perefence_matrix = @schulze.pair_wise_matrix(@voting_proiles, @candidate_index)
  #       @schulze.strongest_path_matrix pair_wise_perefence_matrix
  #   end
  # end

  describe '#strongest_path_matrix' do
    it 'should calculate the strongest path matrix from the example given on wiki' do
      input = [
          [0, 20, 26, 30, 22],
          [25, 0, 16, 33, 18],
          [19, 29, 0, 17, 24],
          [15, 12, 28, 0, 14],
          [23, 27, 21, 31, 0]
      ]

      output = [
          [0, 28, 28, 30, 24],
          [25, 0, 28, 33, 24],
          [25, 29, 0, 29, 24],
          [25, 28, 28, 0, 24],
          [25, 28, 28, 31, 0]
      ]

      #pair_wise_perefence_matrix = @schulze.pair_wise_matrix(@voting_proiles, @candidate_index)
      expect(@schulze.strongest_path_matrix Matrix[input]).to eq(Matrix[output])
    end
  end

  describe '#social_preference' do
    it 'should output the social preference ranking (wiki example)' do

      input = [
          [0, 28, 28, 30, 24],
          [25, 0, 28, 33, 24],
          [25, 29, 0, 29, 24],
          [25, 28, 28, 0, 24],
          [25, 28, 28, 31, 0]
      ]

      candidate_index = {
          'A' => 0,
          'B' => 1,
          'C' => 2,
          'D' => 3,
          'E' => 4
      }

      expect(@schulze.social_preference_ranking(Matrix[input], candidate_index))
          .to eq(['E', 'A', 'C', 'B', 'D'])
    end
  end
end