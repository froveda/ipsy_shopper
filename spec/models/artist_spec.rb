require'rails_helper'

describe Artist do
  it "has a valid factory" do
    expect(build(:artist)).to be_valid
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
