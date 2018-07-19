class UploadImage
  def self.call(image)
    new(image).call    
  end

  def initialize(image)
    @image = image
  end

  def call
    return Error.new('unprocessable entity') unless image?
    Image.create.tap { |img| img.file.attach(image) }
  end

private 

  def image?
    image.content_type.split('/').include?('image')
  end

  attr_reader :image
end
