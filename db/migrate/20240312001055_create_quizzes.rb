class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.integer :user_id
      t.text :question
      t.text :answer
      t.integer :number_of_times_solved
      t.integer :number_of_correct_answers
      t.integer :number_of_times_we_saw_the_answer

      t.timestamps
    end
  end
end
