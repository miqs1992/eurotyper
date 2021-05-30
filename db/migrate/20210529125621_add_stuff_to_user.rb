class AddStuffToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :team, index: true, foreign_key: true
    add_column :users, :name, :string
    add_column :users, :points, :integer, default: 0, null: false
  end
end
