require 'spec_helper'
require_relative './../../app/services/majority_service.rb'


RSpec.describe MajorityService do
  before :each do
    @voting_profiles = {
        person1: ['A', 'C'],
        person2: ['A', 'C', 'B'],
        person3: ['C', 'D', 'A'],
        person4: ['B']
    }
  end

  describe '#vote' do
    it 'finds the alternatives of highest value' do
      expect(MajorityService.vote(@voting_profiles)).to eq %w[A C]
    end
  end
end