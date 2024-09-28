class CreateNovelsSupports < ActiveRecord::Migration[7.0]
  def change
    create_table :novels_supports do |t|
      t.integer :novel_id
      t.references :user, null: false, foreign_key: true
      t.integer :support_fee
      t.text :comment

      t.timestamps
    end
  end
end
