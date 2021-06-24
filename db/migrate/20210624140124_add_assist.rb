class AddAssist < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :assists, :integer, default: 0, null: false
  end
end
