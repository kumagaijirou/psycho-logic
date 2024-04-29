class CreateThoughts < ActiveRecord::Migration[7.0]
  def change
    create_table :thoughts do |t|
      t.integer :novel_id
      t.integer :user_id
      t.text :thoughts

      t.timestamps
    end
  end
end
