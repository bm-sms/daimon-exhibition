FactoryGirl.define do
  factory :product do
    name 'Awesome product'
    secret false

    trait :secret do
      secret true
    end
  end
end
