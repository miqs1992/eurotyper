class ChangePointstoDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :rounds, :score_factor, :decimal, scale: 2, precision: 6
    change_column :users, :points, :decimal, scale: 2, precision: 6
    change_column :bets, :points, :decimal, scale: 2, precision: 6
  end
end
