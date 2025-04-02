class CreateOneYenArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :one_yen_articles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :article
      t.text :article_prompt
      t.integer :views
      t.integer :prompt_views

      t.timestamps
    end
  end
end
