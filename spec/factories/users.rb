FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    password { SecureRandom.urlsafe_base64(8) }
    password_confirmation { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :user do
      role 'user'
    end

    trait :admin do
      role 'admin'
    end

    trait :user_with_posts do
      after(:create) do |user|
        factory_group = FactoryBot.create(:group)
        user.groups << [factory_group]
        post = FactoryBot.create(:post)
        post.groups << factory_group
      end
    end
  end
end
