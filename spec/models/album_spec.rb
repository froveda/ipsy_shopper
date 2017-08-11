# frozen_string_literal: true

require 'rails_helper'

describe Album do
  it 'has a valid factory' do
    expect(build(:album)).to be_valid
  end

  describe 'fields' do
    it { is_expected.to have_field(:name).of_type(String) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:art) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:songs) }
    it { is_expected.to belong_to(:artist) }
  end
end
