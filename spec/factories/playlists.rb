# frozen_string_literal: true

FactoryGirl.define do
  factory :playlist do
    sequence(:name) { |n| "Playlist#{n}" }

    transient do
      playlists_count 1
    end
  end
end
