class Votings::SchulzesController < ApplicationController
before_action :set_voting, only: [:show]

  def show
    @schulze = SchulzeService.new
    render json: @schulze.calculate_schulze(FormatService.format_voting(@voting))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end