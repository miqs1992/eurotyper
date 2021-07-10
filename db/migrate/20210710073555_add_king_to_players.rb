class AddKingToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :king, :boolean, default: false, null: false
    add_index :players, :king
    add_index :teams, :winner
  end
end
