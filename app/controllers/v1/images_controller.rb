class V1::ImagesController < V1::BaseController
  def create
    @image = UploadImage.call(params['image'])
    render json: @image,
           status: @image.persisted? ? :ok : :unprocessable_entity
  end  
end
