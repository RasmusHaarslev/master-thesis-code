class Votings::RankedsController < ApplicationController
  before_action :set_voting, only: [:show]


  def show
    @voting_service = VotingService.new

    @voting = @voting_service.mapning(@voting)

    winners = @voting_service.ranked_pairs(@voting)

    render json: winners
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end