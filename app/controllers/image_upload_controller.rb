class ImageUploadController < ApplicationController
  respond_to :json

  # ==== DOCUMENTATION ====
  api :POST, "/image_upload", "Uploads an image."
  description "Uploads an image based on a URL."
  param_group :auth, ApplicationController
  param :url, String, desc: "URL of the image"
  param :file, String, desc: "Image file"
  error code: 403, desc: "User not logged in."
  error code: 422, desc: "The URL does not point to an image"
  error code: 422, desc: "The URL does not exist"
  error code: 422, desc: "The URL is blank"
  error code: 422, desc: "The file is not an image"
  formats ['json']
  # ==== ACTION ====
  def create
    uploader = GenericImageUploader.new

    # We upload from a url
    if create_params[:url]
      url = create_params[:url]
      begin
        # Download the image
        uploader.download!(url)

        # Store it in the store (S3 in production)
        uploader.store!

        respond_with uploader, format: :json, location: ''
      rescue CarrierWave::IntegrityError => e
        # Thrown when it's not an image file
        render json: error_object("url", e.message), status: :unprocessable_entity
      rescue CarrierWave::DownloadError => e
        # Thrown when the download is taking too long or when it's not a valid URL
        if e.message == "trying to download a file which is not served over HTTP"
          render json: error_object("url", "This URL is not valid."), status: :unprocessable_entity
        else
          render json: error_object("url", "We're sorry but the image that you tried to upload is too big. Please download it to your computer first or choose a smaller image."), status: :unprocessable_entity
        end
      end
    # We upload a file
    elsif create_params[:file]
      begin
        # Cache the image
        uploader.cache!(create_params[:file])

        # Store it in the store (S3 in production)
        uploader.store!

        respond_with uploader, format: :json, location: ''
      rescue CarrierWave::IntegrityError => e
        # Thrown when it's not an image file
        render json: error_object("file", e.message), status: :unprocessable_entity
      end
    end
  end

  private
  def create_params
    params.permit(:url, :file)
  end
end
