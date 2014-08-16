class UserImageUploader < ImageUploader

  # Full images are maximal 1920px wide and 1920px high
  version :full do
    process resize_to_limit: [FULL_IMAGE_SIZE, FULL_IMAGE_SIZE]
  end

  # Thumbs are maximal 430px wide
  version :thumb do
    process resize_to_limit: [430, nil]
  end

  version :index do
    process :resize_to_fill => [200,200]
  end

  # Override the JSON
  def as_json
    {
      identifier: self.identifier,
      url: self.full.url,
      thumb_url: self.thumb.url
    }.as_json
  end
end
