class Votings::KemeniesController < ApplicationController
  before_action :set_voting, only: [:show]

  def show
    @kemeny = KemenyService.new(FormatService.format_voting(@voting))
    render json: @kemeny.winner(JSON.parse(@voting.alternatives))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end