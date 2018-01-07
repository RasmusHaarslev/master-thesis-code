class Votings::SchulzesController < ApplicationController
before_action :set_voting, only: [:show]
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

  def show
    @voting_service = VotingService.new

    @voting = @voting.as_json(include: 'preferences')
    @voting['preferences'] = @voting['preferences'].map { |preference|
      JSON.parse(preference['preference'])
    }

    @voting['time_preferences'] = @voting['preferences'].map { |p|
      p['time_preferences']
    }

    @voting['movie_preferences'] = @voting['preferences'].map { |p|
      p['movie_preferences']
    }

    @voting['cinema_preferences'] = @voting['preferences'].map { |p|
      p['cinema_preferences']
    }

    time_preferences = Hash.new
    @voting['time_preferences'].each_with_index do |item, index|
      time_preferences[index] = item
    end

    movie_preferences = Hash.new
    @voting['movie_preferences'].each_with_index do |item, index|
      movie_preferences[index] = item
    end

    cinema_preferences = Hash.new
    @voting['cinema_preferences'].each_with_index do |item, index|
      cinema_preferences[index] = item
    end

    @voting['time_preferences'] = time_preferences
    @voting['movie_preferences'] = movie_preferences
    @voting['cinema_preferences'] = cinema_preferences


    @voting['associations'] = @@graph

    winners = @voting_service.schulze(@voting)

    render json: winners
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end