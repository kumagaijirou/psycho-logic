class OneYenArticle < ApplicationRecord
  belongs_to :user
  scope :title_contains, ->(word) { where("title LIKE ?", "%#{word}%") }
  scope :order_by_views, -> { order(views: :desc) }
end
