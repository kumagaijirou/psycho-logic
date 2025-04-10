class AudioReading < ApplicationRecord
  has_one_attached :audio_file
  belongs_to :user # 製作者
  belongs_to :novel, optional: true
  belongs_to :author, class_name: "User", foreign_key: "author_user_id", optional: true
  
    before_create :set_default_play_count
  
    validate :audio_file_format
  
    private
  
    def audio_file_format
      return unless audio_file.attached?
    
      acceptable_types = ["audio/mpeg", "audio/wav", "audio/ogg", "audio/mp4", "audio/x-m4a"] 
    
      unless acceptable_types.include?(audio_file.content_type)
        errors.add(:audio_file, "はMP3, WAV, OGG, M4A形式のみアップロード可能です。")
      end
    end
  
    def set_default_play_count
      self.play_count ||= 0
    end
end