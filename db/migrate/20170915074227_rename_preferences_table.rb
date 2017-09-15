class RenamePreferencesTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :preferences, :voting_preferences
  end
end
