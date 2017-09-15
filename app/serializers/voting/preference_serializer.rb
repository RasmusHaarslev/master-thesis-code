class Voting::PreferenceSerializer < ActiveModel::Serializer
  attributes :id, :preference, :voting_id

  def preference
    JSON.parse(object[:preference])
  end
end