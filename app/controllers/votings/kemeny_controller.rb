class Votings::KemenyController < ApplicationController
  before_action :set_action, only: [:show]

  def show
    @kemeny = KemenyService.new(FormatService.format_voting(@voting))
    @kemeny.getWinner(JSON.parse(@voting.alternatives))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end