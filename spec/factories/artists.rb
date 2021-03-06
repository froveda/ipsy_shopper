# frozen_string_literal: true

FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "Artist#{n}" }
    bio Faker::Lorem.paragraph(2)
  end
end
