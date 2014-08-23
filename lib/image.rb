class Image
  def initialize(identifier = nil, url = nil, thumb_url = nil)
    @identifier = identifier unless identifier.nil?
    @url = url unless url.nil?
    @thumb_url = thumb_url unless thumb_url.nil?
  end
end
