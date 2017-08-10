# frozen_string_literal: true

FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "Album#{n}" }
    art { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'sample.jpg')) }
    
    artist
  end
end
