class GenericImageUploader < ImageUploader
  # Calculate an md5 hash of the file
  def md5
    @md5 ||= Digest::MD5.hexdigest(file.read.to_s)
  end

  # Override filename to include the MD5 digest
  def filename
    if super
      @name ||= "#{md5}-#{super}"
    end
  end

  # Override the JSON
  def as_json
    {
      identifier: self.identifier,
      url: self.url,
    }.as_json
  end
end
