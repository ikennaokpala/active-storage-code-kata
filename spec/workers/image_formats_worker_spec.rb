require 'rails_helper'

describe ImageFormatsWorker, type: :job do
  let(:worker) { described_class.new }
  let(:image) { create(:image) }
  let(:formats) { image.reload.formats }
  let(:format_files) { formats.map(&:filename).map(&:to_s) }

  it { is_expected.to be_processed_in :default }
  it { is_expected.to be_retryable false }

  describe '#perform' do
    subject { worker.perform(image.id) }

    it 'returns a valid job status' do
      expect(subject).to eq 'OK'
    end

    context 'when image id is supplied' do
      before { subject }

      it 'creates other image formats' do
        expect(formats.count).to eq(2)
        expect(format_files).to match_array(['sample.jpg', 'sample.gif'])
      end
    end
  end
end
