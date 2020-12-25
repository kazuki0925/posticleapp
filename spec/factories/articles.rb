FactoryBot.define do
  factory :article do
    title {'テストタイトルtesttitle'}
    category_id { Faker::Number.between(from: 0, to: 12) }
    sampletext = "あ"
    14999.times do
      sampletext += "あ"
    end
    text {sampletext}
    association :user
    after(:build) do |article|
      article.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
