FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end

    sequence :name do |n|
      "name_#{n}"
    end

    password { '12345678' }

    trait :admin do
      role { User.roles[:admin] }
    end
  end
end
