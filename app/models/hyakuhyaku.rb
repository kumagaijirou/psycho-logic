class Hyakuhyaku < ApplicationRecord
  belongs_to :user

  validates :front_comment, presence: true, length: { maximum: 100 }
  validates :back_comment, presence: true, length: { maximum: 100 }
end
