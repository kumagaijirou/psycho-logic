class Novel < ApplicationRecord
  belongs_to :user
  has_many :thoughts
  has_many :novels_supports
end
