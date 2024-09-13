class CreateSupports < ActiveRecord::Migration[7.0]
  def change
    create_table :supports do |t|
      t.integer :task_id
      t.integer :user_id
      t.integer :support_fee
      t.text :comment

      t.timestamps
    end
  end
end
