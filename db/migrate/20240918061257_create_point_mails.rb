class CreatePointMails < ActiveRecord::Migration[7.0]
  def change
    create_table :point_mails do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :send_user_id
      t.string :send_user_email
      t.string :title
      t.text :content
      t.integer :send_dice_point
      t.datetime :send_date
      t.boolean :open, default: false

      t.timestamps
    end
  end
end
