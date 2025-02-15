class CreateHyakuhyakus < ActiveRecord::Migration[7.0]
  def change
    create_table :hyakuhyakus do |t|
      t.references :user, null: false, foreign_key: true
      t.text :front_comment
      t.text :back_comment
      t.integer :number_of_times_seen
      t.integer :number_of_refunds

      t.timestamps
    end
  end
end
