# frozen_string_literal: true

FactoryGirl.define do
  factory :song do
    sequence(:name) { |n| "Song#{n}" }
    duration        Faker::Number.number(10)
    genre           Faker::Lorem.word
    featured        false
    
    album

    factory :featured_song do
      featured true
      description Faker::Lorem.paragraphs
      here { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'sample.jpg')) }
    end

    transient do
      songs_count 1
    end
    
    after(:create) do |user|
      user.playlists = [ create(:playlist) ]
    end
  end
end
