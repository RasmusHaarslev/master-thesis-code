class ParserService

  def initialize(input)
    @lexer = LexerService.new(input)
  end

  def parse
    @voters           = @lexer.voters
    @movies           = @lexer.movies
    @preference_lines = @lexer.preferences

    parsed_hash = { voters: @voters, movies: @movies }

    @preference_lines.each do |tokens|
      voter, *preferences = tokens
      parsed_preferences  = parse_preferences(preferences)
      parsed_hash[voter]  = parsed_preferences
    end
  end

  def parse_preferences(preferences)
    parsed_array = []

    until preferences.empty? do
      preference_array = []
      preference_array << preferences.shift

      until preferences.first == '>' do
        preferences.shift
        preference_array << preferences.shift
      end

      parsed_array << preference_array
    end

    parsed_array
  end
end