class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.string :preference
      t.references :votings, foreign_key: true
    end
  end
end
