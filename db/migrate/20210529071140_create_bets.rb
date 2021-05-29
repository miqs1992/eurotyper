class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.boolean :bonus, default: false, null: false
      t.integer :score1, default: 0, null: false
      t.integer :score2, default: 0, null: false
      t.integer :points, default: 0, null: false
      t.timestamps
    end

    add_index :bets, [:user_id, :match_id], unique: true
  end
end
