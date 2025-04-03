class CreateNovelServices < ActiveRecord::Migration[7.0]
  def change
    create_table :novel_services do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :subtitle
      t.string :url1
      t.string :url2
      t.string :url3
      t.text :content
      t.integer :views

      t.timestamps
    end
  end
end
