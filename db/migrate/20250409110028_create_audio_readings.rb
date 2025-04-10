class CreateAudioReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :audio_readings do |t|
      t.string :title
      t.string :subtitle
      t.references :user, null: false, foreign_key: true
      t.references :novel, null: false, foreign_key: true
      t.integer :play_count
      t.integer :author_user_id

      t.timestamps
    end
  end
end
