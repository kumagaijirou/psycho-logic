class CreateFeedbackAndInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :feedback_and_inquiries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :service_name
      t.text :content
      
      t.timestamps
    end
  end
end
