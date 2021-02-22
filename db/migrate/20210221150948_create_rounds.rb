class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :score_factor, default: 1, null: false
      t.timestamps
    end

    create_table :match_days do |t|
      t.datetime :stop_bet_time, null: false, index: { unique: true }
      t.integer :day_number, null: false, index: { unique: true }
      t.references :round, foreign_key: true, index: true
      t.timestamps
    end
  end
end
