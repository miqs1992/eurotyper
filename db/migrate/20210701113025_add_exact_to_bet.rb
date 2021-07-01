class AddExactToBet < ActiveRecord::Migration[6.1]
  def change
    add_column :bets, :exact, :boolean, default: false, null: false
  end
end
