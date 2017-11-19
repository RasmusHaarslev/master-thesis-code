class VotingService

  def initialize
    @schulze      = SchulzeService.new
    @kemeny       = KemenyService.new
    @ranked_pairs = RankedPairsService.new
  end

  #
  # SCHULZE
  #

  def schulze(scenario)
    winners = {}

    winners[:time]     = @schulze.calculate_schulze(scenario['time_preferences']).first

    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @schulze.calculate_schulze(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @schulze.calculate_schulze(cinema_preferences).first

    winners
  end

  def majority_schulze(scenario)
    winners = {}

    winners[:time]     = MajorityService.vote(scenario['time_preferences']).first

    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @schulze.calculate_schulze(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @schulze.calculate_schulze(cinema_preferences).first

    winners
  end

  #
  # KEMENY
  #

  def kemeny(scenario)
    winners = {}

    winners[:time]     = @kemeny.winner(scenario['time_preferences']).first

    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @kemeny.winner(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @kemeny.winner(cinema_preferences).first

    winners
  end

  def majority_kemeny(scenario)
    winners = {}

    winners[:time]     = MajorityService.vote(scenario['time_preferences']).first

    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @kemeny.winner(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @kemeny.winner(cinema_preferences).first

    winners
  end

  #
  # RANKED PAIRS
  #

  def ranked_pairs(scenario)
    winners = {}

    winners[:time] = @ranked_pairs.resolve(scenario['time_preferences']).first

    movie_preferences = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @ranked_pairs.resolve(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @ranked_pairs.resolve(cinema_preferences).first

    winners
  end

  def majority_ranked_pairs(scenario)
    winners = {}

    winners[:time]     = MajorityService.vote(scenario['time_preferences']).first

    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @ranked_pairs.resolve_timed(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @ranked_pairs.resolve_timed(cinema_preferences).first

    winners
  end
end