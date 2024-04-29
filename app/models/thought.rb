class Thought < ApplicationRecord
  belongs_to :novel
  belongs_to :user
end
