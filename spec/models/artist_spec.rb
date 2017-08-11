# frozen_string_literal: true

require 'rails_helper'

describe Artist do
  it 'has a valid factory' do
    expect(build(:artist)).to be_valid
  end

  describe 'fields' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:bio).of_type(String) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:albums) }
  end
end
