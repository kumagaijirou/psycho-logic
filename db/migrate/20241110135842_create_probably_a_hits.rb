class CreateProbablyAHits < ActiveRecord::Migration[7.0]
  def change
    create_table :probably_a_hits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :service_name
      t.integer :service_id
      t.integer :creater_user_id
      t.string :rank

      t.timestamps
    end
  end
end
