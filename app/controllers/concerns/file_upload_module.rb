module FileUploadModule
  extend ActiveSupport::Concern

  def update_attachment(params_attachment, model, attr, caption_attr, uploader) 
    if update_attachment?(params_attachment, model, attr)
      model.send("#{attr}=".to_sym, upload_file(uploader, params_attachment[:url]))
      model[caption_attr] = params_attachment[:caption]
      # Set that we've uploaded an attachment. This means we have to return the new record in the response.
      @attachment_uploaded = true
    elsif update_attachment_caption?(params_attachment, model, attr)
      model[caption_attr] = params_attachment[:caption]
    else
      model.send("remove_#{attr}!")
      model[caption_attr] = nil
    end
  end

  private
  def update_attachment_caption?(params_attachment, model, attr)
    # Update the image caption if the image is not changes (their identifiers match)
    params_attachment.present? and params_attachment[:identifier].eql?(model[attr])
  end

  def update_attachment?(params_attachment, model, attr)
    # Current image is nil and we're uploading one.
    result = (model[attr].nil? and params_attachment.present?)
    # Current image is different from the one we're uploading
    result = result or (params_attachment.present? and model[attr] != params_attachment[:identifier])
  end

  # Uploads and returns a file uploaded using the Carrierwave uploader `uploader` from url `url`
  def upload_file(uploader, url)
    uri = URI.parse(url)
    if uri.host.nil?
      # Local, prepend url
      file = File.open(uploader.root + url)
    else
      # Add a scheme if the url is of the form "//host.com/assets/"
      uri.scheme = "http" if uri.scheme.nil?
      # Remote
      uploader.download!(uri.to_s)
      file = uploader.file
    end
    file
  end
end
