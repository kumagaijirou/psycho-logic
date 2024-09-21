class CreateMiniKnowHows < ActiveRecord::Migration[7.0]
  def change
    create_table :mini_know_hows do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :viewing_fee
      t.integer :number_of_times_seen
      t.integer :number_of_refunds

      t.timestamps
    end
  end
end
