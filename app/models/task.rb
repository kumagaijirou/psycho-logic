class Task < ApplicationRecord
  belongs_to :user
  has_many :supports
  has_one_attached :image
  # default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true, numericality: {only_integer: true}
  validates :content, presence: true, length: { maximum: 140 }
  validates :bet_user_id, presence: true, numericality: {only_integer: true}
  validates :amount_bet, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :deadline_at, presence: true
  validate :date_before_start
  
  def date_before_start
    return if :deadline_at.blank?
    errors.add(:deadline_at, "は今日以降のものを選択してください") if deadline_at < Date.today
  end

end