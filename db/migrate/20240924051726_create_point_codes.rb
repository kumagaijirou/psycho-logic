class CreatePointCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :point_codes do |t|
      t.string :code
      t.integer :point
      t.integer :user_id
      t.datetime :used_at

      t.timestamps
    end
  end
end
