class CreateFivePercentageReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :five_percentage_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :service_name
      t.string :url
      t.integer :price
      t.string :price_supplement
      t.string :status
      t.text :content

      t.timestamps
    end
  end
end
