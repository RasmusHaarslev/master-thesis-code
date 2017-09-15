class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.string :preference
      t.references :voting, foreign_key: true
    end
  end
end
