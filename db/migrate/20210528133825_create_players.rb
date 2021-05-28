class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.integer :position, default: 0, null: false
      t.integer :goals, default: 0, null: false, index: true
      t.timestamps
    end

    add_reference :users, :player, index: true, foreign_key: true
  end
end
