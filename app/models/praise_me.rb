class PraiseMe < ApplicationRecord
  belongs_to :user
  has_many :praises
  validates :comment, presence: true, length: { maximum: 300 }
end
