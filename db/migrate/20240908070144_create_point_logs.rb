class CreatePointLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :point_logs do |t|
      t.integer :user_id
      t.string :service_name
      t.string :category
      t.integer :dice_point

      t.timestamps
    end
  end
end
