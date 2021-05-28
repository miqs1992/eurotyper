class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :match_day, null: false, foreign_key: true
      t.references :team1, foreign_key: { to_table: :teams }, null: false
      t.references :team2, foreign_key: { to_table: :teams }, null: false
      t.datetime :start_time, null: false
      t.integer :score1, default: 0, null: false
      t.integer :score2, default: 0, null: false
      t.boolean :finished, default: false, null: false
      t.timestamps
    end
  end
end
