require 'faker'

FactoryGirl.define do
  factory :note do |f|
    f.title {Faker::Name.first_name}
    f.content {Faker::Name.last_name}
  end
end