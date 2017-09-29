require 'securerandom'

class GeneratePreferencesService

  attr_accessor :preferences

  def initialize(voterAmount, alternativeAmount)
    @voters = randomArray(voterAmount)
    @alternatives = randomArray(alternativeAmount)
    @preferences = writePreferenceString()
  end

  private

  def randomArray(iterations)
    result = []
    while result.uniq().length < iterations
      result.push(SecureRandom.hex(3))
    end
    return result.uniq()
  end

  def writePreferenceString
    result = String.new
    result << @voters.join(',') + "\n"
    result << @alternatives.join(',') + "\n\n"

    @voters.each do |voter|
      result << voter + ': ' + @alternatives.shuffle().join('>') + "\n"
    end
    return result
  end

end