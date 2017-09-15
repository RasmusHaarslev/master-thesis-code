class Votings::PreferencesController < ApplicationController
  before_action :set_voting, only: %i[create]

  # POST /votings/:voting_id/preference
  def create
    @preference = Voting::Preference.new(preference: JSON.generate(preference_params[:preference]))

    if @voting.preferences << @preference
      render nothing: true, status: :ok
    else
      render @preference.errors, status: :unprocessable_entity
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
