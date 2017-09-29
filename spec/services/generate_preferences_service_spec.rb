require 'spec_helper'
require_relative './../../app/services/generate_preferences_service.rb'

RSpec.describe GeneratePreferencesService do
  describe 'hat' do
    @output = GeneratePreferencesService.new(3,7)
    puts @output.preferences
  end

end