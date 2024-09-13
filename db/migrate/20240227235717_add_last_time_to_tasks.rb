class AddLastTimeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :last_time_at, :datetime
    add_column :tasks, :last_message, :text
  end
end
