class CollectionCoverUploader < ImageUploader
  # Full images are maximal 1920px wide and 1920px high
  version :full do
    process resize_to_limit: [FULL_IMAGE_SIZE, FULL_IMAGE_SIZE]
  end

  # Thumb to show in the introduction
  version :thumb_introduction do
    # Resize to 200x200 (and crop)
    process :resize_to_fill => [200, 200]
  end

  version :thumb do
    # Resize to 120x120 (and crop)
    process :resize_to_fill => [120, 120]
  end

  # Override the JSON
  def as_json
    {
      url: self.url,
      thumb_url: self.thumb.url
    }.as_json
  end
end
