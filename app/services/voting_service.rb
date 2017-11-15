class VotingService

  def initialize
    @schulze = SchulzeService.new
    @kemeny  = KemenyService.new
    @ranked_pairs = RankedPairsService.new
  end

  #
  # SCHULZE
  #

  def schulze(scenario)
    winners = {}

    winners[:time]     = @schulze.calculate_schulze(scenario['time_preferences']).first
    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie]    = @schulze.calculate_schulze(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema]   = @schulze.calculate_schulze(cinema_preferences).first

    winners
  end

  def majority_schulze(scenario)
    winners = {}

    winners[:time]     = MajorityService.vote(scenario['time_preferences']).first
    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie]    = @schulze.calculate_schulze(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema]   = @schulze.calculate_schulze(cinema_preferences).first

    winners
  end

  #
  # KEMENY
  #

  def kemeny(scenario)
    winners = {}

    winners[:time]     = @kemeny.winner(scenario['time_preferences']).first
    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie]    = @kemeny.winner(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema]   = @kemeny.winner(cinema_preferences).first

    winners
  end

  def majority_kemeny(scenario)
    winners = {}

    winners[:time]     = MajorityService.vote(scenario['time_preferences']).first
    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie]    = @kemeny.winner(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema]   = @kemeny.winner(cinema_preferences).first

    winners
  end

  #
  # RANKED PAIRS
  #

  def ranked_pairs(scenario)
    winners = {}

    winners[:time]     = @ranked_pairs.winner(scenario['time_preferences']).first
    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie]    = @ranked_pairs.winner(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema]   = @ranked_pairs.winner(cinema_preferences).first

    winners
  end

  def majority_ranked_pairs(scenario)
    winners = {}

    winners[:time]     = MajorityService.vote(scenario['time_preferences']).first
    movie_preferences  = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie]    = @ranked_pairs.winner(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema]   = @ranked_pairs.winner(cinema_preferences).first

    winners
  end
end