class Voting::Preference < ApplicationRecord
  belongs_to :voting, optional: true
end
