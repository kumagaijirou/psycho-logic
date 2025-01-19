class Thought < ApplicationRecord
  belongs_to :novel
  belongs_to :user

  validates :thoughts, presence: true, length: { maximum: 1500 }
end
