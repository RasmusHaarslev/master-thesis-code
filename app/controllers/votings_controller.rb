class VotingsController < ApplicationController
  before_action :set_voting, only: [:show, :update, :destroy, :preference]

  # GET /votings/1
  # GET /votings/1.json
  def show
    render json: @voting, status: :ok
  end

  # POST /votings
  # POST /votings.json
  def create
    permitted_params                = voting_params
    permitted_params[:alternatives] = JSON.generate(permitted_params[:alternatives].as_json)
    permitted_params[:code]         = SecureRandom.hex(4)

    @voting = Voting.new(permitted_params)

    if @voting.save
      render json: @voting, status: :ok
    else
      render json: @voting.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /votings/1
  # PATCH/PUT /votings/1.json
  def update
    permitted_params                = voting_params
    permitted_params[:alternatives] = JSON.generate(permitted_params[:alternatives])

    if @voting.update(permitted_params)
      render json: @voting, status: :ok
    else
      render nothing: true, status: :ok
    end
  end

  # DELETE /votings/1
  # DELETE /votings/1.json
  def destroy
    @voting.destroy

    render nothing: true, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voting
    @voting = Voting.find_by(code: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def voting_params
    params.require(:voting).permit(
      :title,
      :question,
      alternatives: {
          movies: [],
        times: [],
        cinemas: []}
    )
  end
end
