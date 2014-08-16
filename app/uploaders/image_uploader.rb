class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Full images are maximal 1920px wide and 1920px high
  FULL_IMAGE_SIZE = 1920

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Fixes an issue when try to resize animated gifs.
  process :fix_resize_issue_with_gif
  def fix_resize_issue_with_gif
    if file.extension.downcase == 'gif' && version_name.blank?
      list = ::Magick::ImageList.new.from_blob file.read

      if list.size > 1
        list = list.coalesce
        File.open(current_path, 'wb') { |f| f.write list.to_blob }
      end
    end
  end

end
