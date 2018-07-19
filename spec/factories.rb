FactoryBot.define do
  factory :image do
    after :create do |img|
      img.file.attach(
        io: File.open(Rails.root.join('spec/fixtures/images/sample.png')),
        filename: 'sample.png',
        content_type: 'application/png'
      )
    end
  end
end
