# frozen_string_literal: true

FactoryGirl.define do
  factory :song do
    sequence(:name) { |n| "Song#{n}" }
    duration        Faker::Number.number(10)
    genre           Faker::Lorem.word
    
    album
    after(:create) {|song| song.playlists = [ create(:playlist) ] }
  end
end
