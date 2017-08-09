require'rails_helper'

describe Album do
  it "has a valid factory" do
    expect(build(:album)).to be_valid
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:art) }
  end
end
