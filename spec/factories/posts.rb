FactoryGirl.define do
  factory :post do
    caption "caption default"
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/cat.jpg', 'image/jpg')
  end
end
