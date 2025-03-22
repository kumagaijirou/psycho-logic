class PointMail < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,

  def send_point_send_email
    UserMailer.point_send_email(self).deliver_now
  end
end
