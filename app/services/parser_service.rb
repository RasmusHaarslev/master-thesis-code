class ParserService

  def initialize(input)
    @tokens      = input
    @voters      = input[0]
    @movies      = input[1]
    @preferences = input[2]
  end

  def parse
    parsed_hash = { voters: @voters, movies: @movies, preferences: {} }

    puts 'Entered parse'

    @preferences.each do |tokens|
      voter, *preference = tokens
      parsed_hash[:preferences][voter.to_sym]  = parse_preference(preference)
    end

    parsed_hash
  end

  def parse_preference(preference)
    parsed_array = []

    until preference.empty? do
      preference_array = []
      preference_array << preference.shift

      until preference.first == '>' || preference.empty? do
        preference.shift
        preference_array << preference.shift
      end

      preference.shift
      parsed_array << preference_array
    end

    parsed_array
  end
end