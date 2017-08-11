# frozen_string_literal: true

require 'rails_helper'

describe Song do
  it 'has a valid factory' do
    expect(build(:song)).to be_valid
  end
  
  describe 'fields' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:duration).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:genre).of_type(String) }
    it { is_expected.to have_field(:featured).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:description).of_type(String) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:genre) }

    it { is_expected.to validate_numericality_of(:duration).only_integer(true).greater_than_or_equal_to(0) }
  end
  
  describe 'associations' do
    it { is_expected.to belong_to(:album) }
    it { is_expected.to belong_to(:playlist) }
  end
end
