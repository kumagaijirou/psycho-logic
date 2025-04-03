class CreateOkiniiris < ActiveRecord::Migration[7.0]
  def change
    create_table :okiniiris do |t|
      t.references :user, null: false, foreign_key: true
      t.string :service_name
      t.integer :service_id

      t.timestamps
    end
  end
end
