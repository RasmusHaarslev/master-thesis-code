class ExclusionService

  def self.exclude_one(winner, associations, preferences)
    exclude(associations[winner].keys, preferences)
  end

  def self.exclude_two(first_winner, second_winner, associations, preferences)
    exclude(associations[first_winner][second_winner], preferences)
  end

  private

  def self.exclude(potentials, preferences)
    rest = preferences.map do |key, preference|
      [key, preference.select { |v| potentials.include? v }]
    end

    Hash[rest]
  end
end