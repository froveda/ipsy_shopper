# frozen_string_literal: true

require 'rails_helper'

describe Playlist do
  it 'has a valid factory' do
    expect(build(:playlist)).to be_valid
  end

  describe 'fields' do
    it { is_expected.to have_field(:name).of_type(String) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:songs) }
  end
end
