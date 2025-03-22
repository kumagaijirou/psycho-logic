class FivePercentageReview < ApplicationRecord
  belongs_to :user

  validates :service_name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :price_supplement, presence: true
  validates :status, presence: true
  validates :content, presence: true, length: { maximum: 8000 }
end
