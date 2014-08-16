module FileAttachmentModule
  extend ActiveSupport::Concern

  module ClassMethods
    # Returns the uploader for attribute `attribute` or nil
    # `attribute` is a string
    def uploader_for(attribute)
      uploader_type = self.uploaders[attribute.to_sym]
      return uploader_type.new if uploader_type
      nil
    end
  end
end
