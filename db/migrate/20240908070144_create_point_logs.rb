class CreatePointLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :point_logs do |t|
      t.integer :user_id
      t.string :service_name
      t.integer :service_id
      t.string :category
      t.integer :dice_point

      t.timestamps
      add_index :point_logs, [:user_id, :service_name, :service_id], unique: true
    end
  end
end
