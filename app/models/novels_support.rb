class NovelsSupport < ApplicationRecord
  belongs_to :user
  belongs_to :novel

  validates :comment, presence: true, length: { maximum: 1500 }
  validates :support_fee, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
