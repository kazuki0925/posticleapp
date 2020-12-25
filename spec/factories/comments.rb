FactoryBot.define do
  factory :comment do
    text {'testコメント'}
    association :user
    association :article 
  end
end
