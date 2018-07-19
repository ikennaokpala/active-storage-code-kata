class Error < ActiveModelSerializers::Model
  attr_accessor :message

  def initialize(message)
    @message = message
  end

  def persisted?
    false
  end
end
