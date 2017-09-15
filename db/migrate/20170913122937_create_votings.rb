class CreateVotings < ActiveRecord::Migration[5.0]
  def change
    create_table :votings do |t|
      t.string :title
      t.string :question
      t.string :alternatives
      t.string :code

      t.timestamps
    end
  end
end
