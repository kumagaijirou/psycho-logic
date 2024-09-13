class RenameTaskUserIdToUseaIdInTasks < ActiveRecord::Migration[7.0]
  class CreateTasks < ActiveRecord::Migration[7.0]
    def change  
      create_table :tasks do |t|  
        t.text :content  
        t.integer :user_id  
        t.integer :bet_user_id  
        t.datetime :deadline_at  
        t.integer :amount_bet  
        t.string :status  
  
        t.timestamps  
      end  
      add_index :tasks, :user_id  
    end
  end
end