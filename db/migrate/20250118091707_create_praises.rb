class CreatePraises < ActiveRecord::Migration[7.0]
  def change
    create_table :praises do |t|
      t.integer :praise_me_id
      t.references :user, null: false, foreign_key: true
      t.text :praise_comment
      t.boolean :adopt

      t.timestamps
    end
  end
end
