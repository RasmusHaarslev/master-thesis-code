class VotingService

  @@graph = {
      "12:00" => {
          "Batman" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"],
          "Superman" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Blade Runner" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Daddy's Home 2" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Flatliners" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "The Square" => ["Field's", "Lyngby"],
          "Justice League" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Star Wars: The Last Jedi" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"]
      },
      "15:00" => {
          "Pulp Fiction" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "Superman" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Blade Runner" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Jigsaw" => ["Falkoner", "Dagmar", "Imperial"],
          "Daddy's Home 2" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Flatliners" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "The Square" => ["Field's", "Lyngby"],
          "Justice League" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Star Wars: The Last Jedi" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"]
      },
      "19:00" => {
          "Pulp Fiction" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "Batman" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"],
          "Superman" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Blade Runner" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Jigsaw" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Daddy's Home 2" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Flatliners" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "The Square" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"],
          "Justice League" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Star Wars: The Last Jedi" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"]
      },
      "20:00" => {
          "Pulp Fiction" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "Batman" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"],
          "Superman" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Blade Runner" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Jigsaw" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Daddy's Home 2" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Flatliners" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "The Square" => ["Field's", "Lyngby"],
          "Justice League" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Star Wars: The Last Jedi" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"]
      },
      "21:00" => {
          "Pulp Fiction" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "Batman" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"],
          "Superman" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Blade Runner" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Jigsaw" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Daddy's Home 2" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Flatliners" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "The Square" => ["Field's", "Lyngby"],
          "Justice League" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Star Wars: The Last Jedi" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"]
      },
      "22:00" => {
          "Pulp Fiction" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "Batman" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"],
          "Superman" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Blade Runner" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Jigsaw" => ["Falkoner", "Lyngby", "Dagmar", "Imperial"],
          "Flatliners" => ["Field's", "Lyngby", "Dagmar", "Imperial"],
          "The Square" => ["Field's", "Lyngby"],
          "Justice League" => ["Falkoner", "Lyngby", "Dagmar", "Imperial", "Cinemaxx"],
          "Star Wars: The Last Jedi" => ["Field's", "Lyngby", "Dagmar", "Imperial","Cinemaxx", "Palads"]
      }
  }

  def initialize
    @schulze      = SchulzeService.new
    @kemeny       = KemenyService.new
    @ranked_pairs = RankedPairsService.new
  end

  def mapning(voting)
    voting = voting.as_json(include: 'preferences')
    voting['preferences'] = voting['preferences'].map { |preference|
      JSON.parse(preference['preference'])
    }

    voting['time_preferences'] = voting['preferences'].map { |p|
      p['time_preferences']
    }

    voting['movie_preferences'] = voting['preferences'].map { |p|
      p['movie_preferences']
    }

    voting['cinema_preferences'] = voting['preferences'].map { |p|
      p['cinema_preferences']
    }

    time_preferences = Hash.new
    voting['time_preferences'].each_with_index do |item, index|
      time_preferences[index] = item
    end

    movie_preferences = Hash.new
    voting['movie_preferences'].each_with_index do |item, index|
      movie_preferences[index] = item
    end

    cinema_preferences = Hash.new
    voting['cinema_preferences'].each_with_index do |item, index|
      cinema_preferences[index] = item
    end

    voting['time_preferences'] = time_preferences
    voting['movie_preferences'] = movie_preferences
    voting['cinema_preferences'] = cinema_preferences


    voting['associations'] = @@graph

    voting
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
    winners[:movie] = movie_preferences.values.first.length <= 1 ? movie_preferences.values.first.first : @ranked_pairs.resolve(movie_preferences).first

    cinema_preferences = ExclusionService.exclude_two(winners[:time], winners[:movie], scenario['associations'], scenario['cinema_preferences'])
    winners[:cinema] = cinema_preferences.values.first.length <= 1 ? cinema_preferences.values.first.first : @ranked_pairs.resolve(cinema_preferences).first

    winners
  end
end