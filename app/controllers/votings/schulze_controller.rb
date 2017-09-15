class Votings::SchulzeController < ApplicationController
before_action :set_voting, only: [:show]

  def show
    @schulze = SchulzeService.new()
    @schulze.pair_wise_matrix
    @schulze.strongest_path_matrix()
    @schulze.social_preference_ranking
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end