class FormatService

  def self.format_voting(voting)
    preferences = voting.preferences

    return nil if preferences.nil?

    preferences = preferences.map.with_index do |preference, index|
      [index.to_s, JSON.parse(preference.preference).map { |p| [p] }]
    end

    Hash[preferences]
  end

end