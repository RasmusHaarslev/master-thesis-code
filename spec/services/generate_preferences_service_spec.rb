require 'spec_helper'
require'json'
require_relative './../../app/services/generate_preferences_service.rb'

RSpec.describe GeneratePreferencesService do
  before :each do
    @p = GeneratePreferencesService.new(3, 7, 3, 5)
    File.open('spec/files/temp.json','w') do |f|
      f.write(JSON.pretty_generate(@p.p))
    end
  end

  describe 'sm' do
    it 'something' do

    end
  end


end