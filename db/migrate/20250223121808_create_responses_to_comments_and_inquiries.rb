class CreateResponsesToCommentsAndInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :responses_to_comments_and_inquiries do |t|
      t.integer :feedback_and_inquiries_id
      t.integer :present_dice_point
      t.text :content

      t.timestamps
    end
  end
end
