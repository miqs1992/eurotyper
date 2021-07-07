class AddStageToRound < ActiveRecord::Migration[6.1]
  def change
    add_column :rounds, :stage, :integer, default: 0, null: false
  end
end
