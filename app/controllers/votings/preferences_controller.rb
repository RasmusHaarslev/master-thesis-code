class Votings::PreferencesController < ApplicationController
  before_action :set_voting, only: %i[show create]

  # GET /votings/:voting_id/preferences
  def show
    render json: @voting.preferences, status: :ok
  end

  # POST /votings/:voting_id/preferences
  def create
    @preference = Voting::Preference.new(preference: JSON.generate(preference_params[:preference]))

    unless preference_params[:preference].uniq.length == preference_params[:preference].length
      render json: @preference.errors, status: :unprocessable_entity
      return
    end

    preference_params[:preference].each do |a|
      unless @voting.alternatives.include? a
        render json: @preference.errors, status: :unprocessable_entity
        return
      end
    end

    if @voting.preferences << @preference
      render nothing: true, status: :ok
    else
      render json: @preference.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:voting_id])
  end

  def preference_params
    params.require(:preference).permit(
      { preference: [] }
    )
  end
end
