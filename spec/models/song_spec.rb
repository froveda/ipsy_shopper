# frozen_string_literal: true

require 'rails_helper'

describe Song do
  it 'has a valid factory' do
    expect(build(:song)).to be_valid
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:genre) }

    it { is_expected.to validate_numericality_of(:duration).only_integer(true).greater_than_or_equal_to(0) }
  end
end
