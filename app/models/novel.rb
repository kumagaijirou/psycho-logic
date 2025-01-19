class Novel < ApplicationRecord
  belongs_to :user
  has_many :thoughts
  has_many :novels_supports
  validates :user_id, presence: true, numericality: {only_integer: true}
  validates :work_name, presence: true, length: { maximum: 255 }
  validates :synopsis, presence: true, length: { maximum: 1500 }
  validates :url1, presence: true,
  validates :status, presence: true,
end
