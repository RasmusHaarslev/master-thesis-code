class VotingSerializer < ActiveModel::Serializer
  attributes :code, :title, :question, :alternatives

  def alternatives
    JSON.parse(object[:alternatives])
  end
end
