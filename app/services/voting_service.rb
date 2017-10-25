class VotingService

  def initialize
    @schulze = SchulzeService.new
    @kemeny = KemenyService.new
  end

  def schulze(scenario)
    winners = {}

    winners[:time] = @schulze.calculate_schulze(scenario['time_preferences']).first
    movie_preferences = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = @schulze.calculate_schulze(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = @schulze.calculate_schulze(cinema_preferences).first

    winners
  end

  def kemeny(scenario)
    winners = {}

    winners[:time] = @kemeny.winner(scenario['time_preferences']).first
    movie_preferences = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = @kemeny.winner(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = @kemeny.winner(cinema_preferences).first

    winners
  end

  def majority_schulze(scenario)
    winners = {}

    winners[:time] = MajorityService.vote(scenario['time_preferences']).first
    movie_preferences = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = @schulze.calculate_schulze(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = @schulze.calculate_schulze(cinema_preferences).first

    winners
  end

  def majority_kemeny(scenario)
    winners = {}

    winners[:time] = MajorityService.vote(scenario['time_preferences']).first
    movie_preferences = ExclusionService.exclude_one(winners[:time], scenario['associations'], scenario['movie_preferences'])
    winners[:movie] = @kemeny.winner(movie_preferences).first
    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = @kemeny.winner(cinema_preferences).first

    winners
  end
end