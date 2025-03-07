class FeedbackAndInquiry < ApplicationRecord
  belongs_to :user
  has_many :responses_to_comments_and_inquiries
end
