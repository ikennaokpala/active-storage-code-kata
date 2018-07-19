require 'rails_helper'

RSpec.describe '/v1/images' do
  describe 'POST /v1/images' do
    let(:path_to_image) { Rails.root.join('spec/fixtures/images/sample.png') }
    let(:path_to_txt) { Rails.root.join('spec/fixtures/plain/sample.txt') }
    let(:filename) { File.basename(path_to_image) }
    let(:uploaded_image) { Rack::Test::UploadedFile.new(File.open(path_to_image), 'image/png') }
    let(:params) { { image: uploaded_image } }
    let(:expected) { {} }
    
    subject { post '/v1/images', params: params }

    context 'when valid image is sent' do
      it 'creates and returns a unique identifier for the uploaded image' do
        expect { subject }.to change{ Image.count }.by(1)
        expect(response).to have_http_status(200)
        expect(response).to match_response_schema('v1/image')
      end
    end

    context 'when invalid image is sent' do
      let(:uploaded_image) { Rack::Test::UploadedFile.new(File.open(path_to_txt)) }
      
      it 'raises error' do
        expect { subject }.to change{ Image.count }.by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to match_response_schema('v1/image')
      end
    end
  end
end
