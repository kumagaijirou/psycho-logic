class AddFinalAnswerToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :final_answer, :text
  end
end
