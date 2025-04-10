module AudioReadingsHelper
    def already_purchased?(audio_reading)
      PointLog.exists?(user_id:@current_user.id,service_name: "小説朗読",service_id:@audio_reading.id)
    end
  
    def user_can_afford_from_audio_reading?
      current_user.dice_point >= 100
    end
end
