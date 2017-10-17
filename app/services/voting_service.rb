class VotingService

  attr_accessor :associations, :movie_preferences, :time_preferences, :time_votes, :cinema_preferences

  def initialize(input)
    @associations       = input['associations']
    @movie_preferences  = input['movie_preferences']
    @time_preferences   = input['time_preferences']
    @time_votes         = input['time_votes']
    @cinema_preferences = input['cinema_preferences']
  end

  def schulze
    schulze = SchulzeService.new

    winners = {}

    winners[:time] = schulze.calculate_schulze(@time_preferences).first
    # TODO: Exclude movies
    winners[:movie] = schulze.calculate_schulze(@movie_preferences).first
    # TODO: exclude cinemas
    winners[:cinema] = schulze.calculate_schulze(@cinema_preferences).first

    winners
  end

  def majority_schulze
    schulze = SchulzeService.new

    winners = {}

    winners[:time] = MajorityService.vote(@time_preferences).first
    # TODO: Exclude movies
    winners[:movie] = schulze.calculate_schulze(@movie_preferences).first
    # TODO: exclude cinemas
    winners[:cinema] = schulze.calculate_schulze(@cinema_preferences).first

    winners
  end
end