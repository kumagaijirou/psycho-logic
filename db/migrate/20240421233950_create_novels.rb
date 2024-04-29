class CreateNovels < ActiveRecord::Migration[7.0]
  def change
    create_table :novels do |t|
      t.text :work_name
      t.integer :user_id
      t.text :synopsis
      t.string :url1
      t.string :url2
      t.string :url3
      t.integer :accumulation_dice_point
      t.string :status

      t.timestamps
    end
  end
end
