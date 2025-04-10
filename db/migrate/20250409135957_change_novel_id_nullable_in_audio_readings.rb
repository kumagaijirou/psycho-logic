class ChangeNovelIdNullableInAudioReadings < ActiveRecord::Migration[7.0]
  def change
    change_column_null :audio_readings, :novel_id, true
  end
end