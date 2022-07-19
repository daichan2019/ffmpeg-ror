class Summary < ApplicationRecord
  has_one_attached :video

  def video_url
    video.attached? ? Rails.application.routes.url_helpers.rails_blob_path(video, only_path: true) : nil
  end
end
