class Votings::SchulzesController < ApplicationController
before_action :set_voting, only: [:show]

  def show
    @voting_service = VotingService.new
    @voting_service.schulze(@voting.as_json(include: 'preferences'))

    voting_scenario = JSON.parse(File.read(File.expand_path('db/movie_ass.json')))

    render json: @schulze.calculate_schulze(FormatService.format_voting(@voting))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

end