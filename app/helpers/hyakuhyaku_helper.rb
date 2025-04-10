module HyakuhyakuHelper
  def already_purchased?(hyakuhyaku)
    PointLog.exists?(user_id:@current_user.id,service_name: "百百",service_id:@hyakuhyaku.id)
  end

  def user_can_afford?
    current_user.dice_point >= 50
  end
end
