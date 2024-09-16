class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.string :service_name
      t.integer :service_id

      t.timestamps
      t.index [:user_id, :service_id], unique: true
    end
  end
end
