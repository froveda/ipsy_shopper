require'rails_helper'

describe Playlist do
  it "has a valid factory" do
    expect(build(:playlist)).to be_valid
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
