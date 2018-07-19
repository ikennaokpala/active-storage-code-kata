class FormatsFromImage
  FORMATS = %i[jpg gif].freeze

  def self.call(image_id, formats = FORMATS)
    new(image_id, formats).call
  end
  
  def initialize(image_id, formats = FORMATS)
    @image_id = image_id
    @formats = formats
  end

  def call
    image = Image.find(image_id)
    return if image.nil?
    formats.each { |format| image.formats.attach(convert(image.file, format)) }
  end

  private_constant :FORMATS

private

  attr_reader :image_id, :formats

  def convert(image_file, format)
    image = MiniMagick::Image.read(image_file.blob.download)
    image.format format
    image.write path_to_converted(image_file, format)
    details(image_file, format)
  end

  def details(file, format)
    {
      io: StringIO.new(file.blob.download),
      filename: "#{File.basename(file.filename.to_s, '.*')}.#{format}",
      content_type: "image/#{format}"
    }
  end

  def path_to_converted(file, format)
    @path_to_converted ||= "/tmp/#{File.basename(file.filename.to_s, '.*')}.#{format}"
  end
end
