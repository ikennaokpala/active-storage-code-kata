class ImageFormatsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false
  

  def perform(image_id)
    FormatsFromImage.call(image_id)
    store info: 'Complete'
  end
end
