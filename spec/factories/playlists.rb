# frozen_string_literal: true

FactoryGirl.define do
  factory :playlist do
    sequence(:name) { |n| "Playlist#{n}" }
  end
end
