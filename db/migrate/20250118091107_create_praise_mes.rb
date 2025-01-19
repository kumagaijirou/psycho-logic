class CreatePraiseMes < ActiveRecord::Migration[7.0]
  def change
    create_table :praise_mes do |t|
      t.references :user, null: false, foreign_key: true
      t.text :comment
      t.integer :number_of_people
      t.datetime :deadline
      t.string :phase

      t.timestamps
    end
  end
end
