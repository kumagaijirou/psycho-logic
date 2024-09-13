class AddOpenToThoughts < ActiveRecord::Migration[7.0]
  def change
    add_column :thoughts, :open, :boolean, default: false
  end
end
